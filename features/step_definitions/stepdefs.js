const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After, setDefaultTimeout } = require('@cucumber/cucumber');
const { createObjectFrom, createObjectArrayFrom } = require('./dataTable2Object.js');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { Pool } = require('pg');
const { noSqlData, executeSqlStatements, rollbackSqlStatements, insertIntoPersoonlijstStatement, insertIntoAdresStatement, insertIntoStatement } = require('./postgresqlHelpers.js');
const { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray, fromHash } = require('./dataTable2Array.js');
const { postBevragenRequestWithBasicAuth, handleOAuthRequest, handleOAuthCustomRequest, handleCustomBevragenRequest } = require('./handleRequest.js');
const { tableNameMap, columnNameMap, createAutorisatieSettingsFor, createRequestBody, createBasicAuthorizationHeader, createAdresseringBinnenlandAutorisatieSettingsFor, createVerblijfplaatsBinnenlandAutorisatieSettingsFor } = require('./gba.js');
const { stringifyValues } = require('./stringify.js');

setWorldConstructor(World);

// voor het aanpassen van de default timeout waarde (5s) van cucumber-js
// de default timeout waarde van axios is 0 (geen timeout)
// https://github.com/cucumber/cucumber-js/blob/main/docs/support_files/timeouts.md
setDefaultTimeout(15000);

let pool;
let logSqlStatements = false;
let accessToken;

function createPersoonMetGegevensgroep(burgerservicenummer, gegevensgroep, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];

    switch(gegevensgroep){
        case 'inschrijving':
            sqlData[gegevensgroep] = [ createArrayFrom(dataTable, columnNameMap) ];
            break;
        case 'kiesrecht':
            sqlData["inschrijving"] = [
                [
                    [ 'geheim_ind', '0' ]
                ].concat(createArrayFrom(dataTable, columnNameMap))
            ];
            break;
        case 'verblijfplaats':
            should.fail(`deprecated. Gebruik de nieuwe stap: "Gegeven de persoon met burgerservicenummer '<bsn>' is ingeschreven op het adres met '<element naam>' '<waarde>' met de volgende gegevens"`)
            break;
        default:
            sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
            sqlData[gegevensgroep] = [
                [
                    [ 'volg_nr', '0']
                ].concat(createArrayFrom(dataTable, columnNameMap))
            ];
            break;
    }
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft de volgende '(\w*)' gegevens$/, createPersoonMetGegevensgroep);

Given(/^de persoon heeft de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[gegevensgroep] = [
        gegevensgroep === 'inschrijving'
            ? createArrayFrom(dataTable, columnNameMap)
            : createVoorkomenDataFromArray(createArrayFrom(dataTable, columnNameMap)) 

    ];
});

function getNextStapelNr(sqlData, relatie) {
    let stapelNr = 0;

    Object.keys(sqlData).forEach(function(key) {
        if(key.startsWith(relatie)){
            stapelNr = Number(key.replace(`${relatie}-`, ''));
        }
    });

    return stapelNr+1;
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een '(\w*)' met de volgende gegevens$/, async function (burgerservicenummer, collectieGegevensgroep, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    sqlData[`${collectieGegevensgroep}-${getNextStapelNr(sqlData, collectieGegevensgroep)}`] = [
        createCollectieDataFromArray(collectieGegevensgroep, createArrayFrom(dataTable, columnNameMap))
    ];
});

Given(/^de persoon heeft ?(?:nog)? een '?(?:ex-)?(\w*)' met ?(?:alleen)? de volgende gegevens$/, async function (relatie, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    const stapelNr = getNextStapelNr(sqlData, relatie);
    sqlData[`${relatie}-${stapelNr}`] = [
        createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr-1)
    ];
});

async function createPersoonMetOuder(burgerservicenummer, ouderType, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData["inschrijving"] = [[[ 'geheim_ind', '0' ]]];
    sqlData["persoon"] = [
        createCollectieDataFromArray("persoon", [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];
    sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap))
    ];
}

Given(/^de persoon met burgerservicenummer '(\d*)' heeft een ouder '(\d)' met de volgende gegevens$/, createPersoonMetOuder);

Given(/^(?:de|het) '(.*)' is gecorrigeerd naar de volgende gegevens$/, async function (relatie, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    const foundRelatie = Object.keys(sqlData).findLast(key => key.startsWith(relatie));

    const stapelNr = sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');
    let adres_id;

    sqlData[foundRelatie].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
            if(relatie === 'verblijfplaats') {
                adres_id = data.find(el => el[0] === 'adres_id')[1];
            }
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    if(stapelNr !== undefined){
        sqlData[foundRelatie].push(createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr[1]));
    }
    else {
        let data = createArrayFrom(dataTable, columnNameMap);
        if(adres_id !== undefined) {
            data = [
                ['adres_id', adres_id]
            ].concat(data);
        }
        sqlData[foundRelatie].push(createVoorkomenDataFromArray(data));
    }
});

function wijzigRelatie(relatie, dataTable) {
    should.not.equal('verblijfplaats', `deprecated. Gebruik de nieuwe stap: "En de persoon is vervolgens ingeschreven op adres '<adres id>' met de volgende gegevens"`)

    let sqlData = this.context.sqlData.at(-1);

    const foundRelatie = Object.keys(sqlData).findLast(key => key.startsWith(relatie));

    const stapelNr = sqlData[foundRelatie][0].find(el => el[0] === 'stapel_nr');

    sqlData[foundRelatie].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    if(stapelNr !== undefined) {
        sqlData[foundRelatie].push(createCollectieDataFromArray(relatie, createArrayFrom(dataTable, columnNameMap), stapelNr[1]));
    }
    else {
        sqlData[foundRelatie].push(createVoorkomenDataFromArray(createArrayFrom(dataTable, columnNameMap)));
    }
}

Given(/^(?:de|het) '(.*)' is gewijzigd naar de volgende gegevens$/, wijzigRelatie);

Given(/^adres '(.*)' heeft de volgende gegevens$/, function (adresId, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{'adres':{}}];
    }

    let sqlData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    if(sqlData === undefined) {
        sqlData = { adres: {} };
        this.context.sqlData.push(sqlData);
    }

    sqlData['adres'][adresId] = {
        index: Object.keys(sqlData['adres']).length,
        data: createArrayFrom(dataTable, columnNameMap)
    };
});

Given(/^adres '(.*)' is op '(.*)' geactualiseerd met de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    let sqlData = this.context.sqlData.at(0);

    const oudAdres = sqlData.adres[adresId];
    should.exist(oudAdres, `geen adres gevonden met id '${adresId}'`);
    const adresIndex = oudAdres.index;

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    const nieuwAdresData = oudAdres.data.concat(createArrayFrom(dataTable, columnNameMap));
    sqlData['adres'][nieuwAdresIndex + 1 + ''] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');

    this.context.sqlData.forEach(function(elem) {
        let verblijfplaats = elem['verblijfplaats']?.at(-1);
        if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === adresIndex + '') !== undefined) {
            elem['verblijfplaats'].forEach(function(data) {
                let volgNr = data.find(el => el[0] === 'volg_nr');
                volgNr[1] = Number(volgNr[1]) + 1 + '';
            });

            let nieuwVerblijfplaatsData = [
                [ 'adres_id', nieuwAdresIndex + '' ],
                [ 'volg_nr', '0'],
                [ 'adreshouding_start_datum', ingangsdatum.replaceAll('-', '')],
                [ 'aangifte_adreshouding_oms', 'T' ]
            ];
            if(nieuwGemeenteCode !== undefined) {
                nieuwVerblijfplaatsData.push([ 'inschrijving_gemeente_code', nieuwGemeenteCode[1] ]);
            }

            elem.verblijfplaats.push(nieuwVerblijfplaatsData);
        }
    });
});

Given(/^adres '(.*)' is op '(.*)' infrastructureel gewijzigd met de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    let sqlData = this.context.sqlData.find(el => el['adres'] !== undefined);

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    infrastructureelWijzigenAdres(this.context, adresId, ingangsdatum, nieuwAdresIndex + 1 + '', dataTable);
});

function infrastructureelWijzigenAdres(context, sourceAdresId, ingangsdatum, targetAdresId, dataTable) {
    let sqlData = context.sqlData.find(el => el['adres'] !== undefined);

    const oudAdres = sqlData.adres[sourceAdresId];
    should.exist(oudAdres, `geen adres gevonden met id '${sourceAdresId}'`);
    const adresIndex = oudAdres.index;

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    const nieuwAdresData = JSON.parse(JSON.stringify(oudAdres.data));
    createArrayFrom(dataTable, columnNameMap).forEach(function(elem) {
        let foundElem = nieuwAdresData.find(el => el[0] === elem[0]);
        if(foundElem !== undefined) {
            foundElem[1] = elem[1];
        }
        else {
            nieuwAdresData.push(elem);
        }
    });
    sqlData['adres'][targetAdresId] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    context.sqlData.forEach(function(elem) {
        let verblijfplaats = elem['verblijfplaats']?.at(-1);
        if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === adresIndex + '') !== undefined) {
            elem['verblijfplaats'].forEach(function(data) {
                let volgNr = data.find(el => el[0] === 'volg_nr');
                volgNr[1] = Number(volgNr[1]) + 1 + '';
            });

            let nieuwVerblijfplaatsData = JSON.parse(JSON.stringify(elem['verblijfplaats'].at(-1)));
            nieuwVerblijfplaatsData.find(el => el[0] === 'adres_id')[1] = nieuwAdresIndex + '';
            nieuwVerblijfplaatsData.find(el => el[0] === 'volg_nr')[1] = '0';
            nieuwVerblijfplaatsData.find(el => el[0] === 'adreshouding_start_datum')[1] = ingangsdatum.replaceAll('-', '');

            const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');
            if(nieuwGemeenteCode !== undefined) {
                nieuwVerblijfplaatsData.find(el => el[0] === 'inschrijving_gemeente_code')[1] = nieuwGemeenteCode[1];
            }

            nieuwVerblijfplaatsData.push(['aangifte_adreshouding_oms', 'W'])

            elem.verblijfplaats.push(nieuwVerblijfplaatsData);
        }
    });
}

Given(/^adres '(.*)' is op '(.*)' infrastructureel gewijzigd naar adres '(.*)' met de volgende gegevens$/, function(sourceAdresId, ingangsdatum, targetAdresId, dataTable) {
    infrastructureelWijzigenAdres(this.context, sourceAdresId, ingangsdatum, targetAdresId, dataTable);
});

Given(/^(?:adres|de adressen) '(.*)' (?:is|zijn) op '(.*)' samengevoegd tot adres '(.*)' met de volgende gegevens$/, function (sourceAdresIds, ingangsdatum, targetAdresId, dataTable) {
    let sqlData = this.context.sqlData;
    let adressenData = sqlData.at(0);

    const nieuwAdresIndex = Object.keys(adressenData['adres']).length;
    const nieuwAdresData = createArrayFrom(dataTable, columnNameMap);
    adressenData['adres'][targetAdresId] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    const nieuwGemeenteCode = nieuwAdresData.find(el => el[0] == 'gemeente_code');

    sourceAdresIds.split(',')
                  .map((item)=> item.trim())
                  .forEach(function(adresId) {
        const adresIndex = sqlData.at(0).adres[adresId]?.index;
        should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

        sqlData.forEach(function(elem) {
            let verblijfplaats = elem['verblijfplaats']?.at(-1);
            if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === adresIndex + '') !== undefined) {
                elem['verblijfplaats'].forEach(function(data) {
                    let volgNr = data.find(el => el[0] === 'volg_nr');
                    volgNr[1] = Number(volgNr[1]) + 1 + '';
                });
    
                let nieuwVerblijfplaatsData = [
                    [ 'adres_id', nieuwAdresIndex + '' ],
                    [ 'volg_nr', '0'],
                    [ 'adreshouding_start_datum', ingangsdatum.replaceAll('-', '')],
                    [ 'aangifte_adreshouding_oms', 'W' ]
                ];
                if(nieuwGemeenteCode !== undefined) {
                    nieuwVerblijfplaatsData.push([ 'inschrijving_gemeente_code', nieuwGemeenteCode[1] ]);
                }
    
                elem.verblijfplaats.push(nieuwVerblijfplaatsData);
            }
        });
    });
});

Given(/^adres '(.*)' is gesplitst in adressen met de volgende gegevens$/, function (_, dataTable) {
    let sqlData = this.context.sqlData;
    let adressenData = sqlData.at(0);
    let adresIndex = Object.keys(adressenData).length;

    dataTable.hashes().forEach(function(adresData) {
        const adresId = adresData.adres;
        delete adresData.adres;

        adressenData['adres'][adresId] = {
            index: adresIndex,
            data: fromHash(adresData, columnNameMap)
        };

        adresIndex++;
    });
});

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op adres '(.*)' met de volgende gegevens$/, function (burgerservicenummer, adresId, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }

    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData['persoon'] = [
        createCollectieDataFromArray('persoon', [
            ['burger_service_nr', burgerservicenummer]
        ])
    ];

    sqlData['inschrijving'] = [[[ 'geheim_ind', '0' ]]];

    sqlData['verblijfplaats'] = [
        [
            [ 'adres_id', adresIndex + '' ],
            [ 'volg_nr', '0']
        ].concat(createArrayFrom(dataTable, columnNameMap))
    ];
});

Given(/^de persoon is ingeschreven op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let sqlData = this.context.sqlData.at(-1);

    sqlData['verblijfplaats'] = [
        [
            [ 'adres_id', adresIndex + '' ],
            [ 'volg_nr', '0']
        ].concat(createArrayFrom(dataTable, columnNameMap))
    ];
});

Given(/^de persoon is vervolgens ingeschreven op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let sqlData = this.context.sqlData.at(-1);

    sqlData['verblijfplaats'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    sqlData['verblijfplaats'].push([
        [ 'adres_id', adresIndex + '' ],
        [ 'volg_nr', '0']
    ].concat(createArrayFrom(dataTable, columnNameMap)));
});

Given(/^er zijn (\d*) personen ingeschreven op adres '(.*)' met de volgende gegevens$/, function (aantal, adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let i = 0;
    while(i < Number(aantal)) {
        i++;

        this.context.sqlData.push({});

        let sqlData = this.context.sqlData.at(-1);
    
        const burgerservicenummer = (i + '').padStart(9, '0');
        sqlData['persoon'] = [
            createCollectieDataFromArray('persoon', [
                ['burger_service_nr', burgerservicenummer]
            ])
        ];
    
        sqlData['inschrijving'] = [[[ 'geheim_ind', '0' ]]];
    
        sqlData['verblijfplaats'] = [
            [
                [ 'adres_id', adresIndex + '' ],
                [ 'volg_nr', '0']
            ].concat(createArrayFrom(dataTable, columnNameMap))
        ];
    }
});

Given(/^de afnemer met indicatie '(.*)' heeft de volgende '(.*)' gegevens$/, function (afnemerCode, tabelNaam, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData[tabelNaam] = [
        [
            [ 'afnemer_code', afnemerCode ],
            ['geheimhouding_ind', 0],
            ['verstrekkings_beperking', 0]
        ].concat(createArrayFrom(dataTable, columnNameMap))];
});

Given(/^de geauthenticeerde consumer heeft de volgende '(.*)' gegevens$/, function (_, dataTable) {
    this.context.afnemerId = dataTable.hashes()[0].naam !== undefined
        ? dataTable.hashes().find(param => param.naam === 'afnemerID').waarde
        : dataTable.hashes()[0].afnemerID;

    this.context.gemeenteCode = dataTable.hashes()[0].naam !== undefined
        ? dataTable.hashes().find(param => param.naam === 'gemeenteCode').waarde
        : dataTable.hashes()[0].gemeenteCode;
});

Given(/^gemeente '(.*)' heeft de volgende gegevens$/, function (gemeenteId, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [{ gemeente:{} }];
    }

    let sqlData = this.context.sqlData.find(e => Object.keys(e).includes('gemeente'));
    if(sqlData === undefined) {
        sqlData = { gemeente:{} };
        this.context.sqlData.push(sqlData);
    }

    sqlData['gemeente'][gemeenteId] = {
        index: Object.keys(sqlData['gemeente']).length,
        data: createArrayFrom(dataTable, columnNameMap)
    };
});

Given(/^gemeente '(.*)' is samengevoegd met de volgende gegevens$/, function (gemeenteId, dataTable) {
    let gemeenteData = this.context.sqlData.find(el => el['gemeente'] !== undefined);

    const gemeente = gemeenteData.gemeente[gemeenteId];
    should.exist(gemeente, `geen gemeente gevonden met id '${gemeenteId}'`);

    gemeente.data = gemeente.data.concat(createArrayFrom(dataTable, columnNameMap));

    const oudGemeenteCode = gemeente.data.find(el => el[0] === 'gemeente_code')[1];
    const nieuweGemeenteCode = gemeente.data.find(el => el[0] === 'nieuwe_gemeente_code')[1];
    const ingangsdatum = gemeente.data.find(el => el[0] === 'tabel_regel_eind_datum')[1];

    let gewijzigdAdressenIds = [];
    this.context.sqlData.forEach(function(elem) {
        let adres = elem['adres'];
        if(adres !== undefined) {
            Object.keys(adres).forEach(function(adresId) {
                if(adres[adresId].data.find(el => el[0] === 'gemeente_code' && el[1] === oudGemeenteCode)) {
                    const nieuwAdresIndex = Object.keys(adres).length;
                    const nieuwAdresData = JSON.parse(JSON.stringify(adres[adresId].data));
                    nieuwAdresData.find(el => el[0] === 'gemeente_code')[1] = nieuweGemeenteCode;
                    adres[nieuwAdresIndex + 1 + ''] = {
                        index: nieuwAdresIndex,
                        data: nieuwAdresData
                    };

                    gewijzigdAdressenIds.push([adresId, nieuwAdresIndex + 1 + '']);
                }
            });
        }
    });

    const sqlDatas = this.context.sqlData;
    const adressen = this.context.sqlData.find(el => el['adres'] !== undefined);

    gewijzigdAdressenIds.forEach(function(elem) {
        const oudAdres = adressen.adres[elem[0]];
        const nieuwAdres = adressen.adres[elem[1]];

        sqlDatas.forEach(function(elem) {
            let verblijfplaats = elem['verblijfplaats']?.at(-1);
            if(verblijfplaats?.find(el => el[0] === 'adres_id' && el[1] === oudAdres.index + '') !== undefined) {
                elem['verblijfplaats'].forEach(function(data) {
                    let volgNr = data.find(el => el[0] === 'volg_nr');
                    volgNr[1] = Number(volgNr[1]) + 1 + '';
                });

                let nieuwVerblijfplaatsData = JSON.parse(JSON.stringify(elem['verblijfplaats'].at(-1)));
                nieuwVerblijfplaatsData.find(el => el[0] === 'adres_id')[1] = nieuwAdres.index + '';
                nieuwVerblijfplaatsData.find(el => el[0] === 'volg_nr')[1] = '0';
                nieuwVerblijfplaatsData.find(el => el[0] === 'inschrijving_gemeente_code')[1] = nieuweGemeenteCode + '';
                nieuwVerblijfplaatsData.find(el => el[0] === 'adreshouding_start_datum')[1] = ingangsdatum + '';
                nieuwVerblijfplaatsData.push(['aangifte_adreshouding_oms', 'W'])

                elem.verblijfplaats.push(nieuwVerblijfplaatsData);
            }
        });
    });
});

Given(/^de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres '(.*)' met de volgende gegevens$/, function (adresId, dataTable) {
    const adressenData = this.context.sqlData.find(e => Object.keys(e).includes('adres'));
    should.exist(adressenData, 'geen adressen gevonden');
    const adresIndex = adressenData.adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

    let sqlData = this.context.sqlData.at(-1);

    sqlData['verblijfplaats'].forEach(function(data) {
        let volgNr = data.find(el => el[0] === 'volg_nr');
        if(volgNr[1] === '0') {
            data.push(['onjuist_ind','O']);
        }
        volgNr[1] = Number(volgNr[1]) + 1 + '';
    });

    sqlData['verblijfplaats'].push([
        [ 'adres_id', adresIndex + '' ],
        [ 'volg_nr', '0']
    ].concat(createArrayFrom(dataTable, columnNameMap)));
});

async function createOuder(ouderType, dataTable) {
    let sqlData = this.context.sqlData.at(-1);

    sqlData[`ouder-${ouderType}`] = [
        createCollectieDataFromArray(ouderType, createArrayFrom(dataTable, columnNameMap))
    ];
}

Given(/^de persoon heeft een ouder '(\d)' met de volgende gegevens$/, createOuder);

async function handleRequest(context, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth?.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    const heeftAutorisatieSettings = context.sqlData.filter(s => s['autorisatie'] !== undefined).length > 0;
    if (!heeftAutorisatieSettings &&
        (context.createDefaultAutorisation === undefined || context.createDefaultAutorisation)
       ) {
        let sqlData = context.sqlData.at(-1);
        sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
    }

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    if(context.oAuth.enable){
        const result = await handleOAuthRequest(accessToken, context.oAuth, afnemerId, url, dataTable);
        context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        context.response = await postBevragenRequestWithBasicAuth(url, createBasicAuthorizationHeader(afnemerId, gemeenteCode), dataTable);
    }
}

When(/^bewoning wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = true;

    await handleRequest(this.context, dataTable);
});

When(/^gba bewoning wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = false;

    await handleRequest(this.context, dataTable);
});

async function handleCustomRequest(context, verb) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    const heeftAutorisatieSettings = context.sqlData.filter(s => s['autorisatie'] !== undefined).length > 0;
    if (!heeftAutorisatieSettings &&
        (context.createDefaultAutorisation === undefined || context.createDefaultAutorisation)
       ) {
        let sqlData = context.sqlData.at(-1);
        sqlData['autorisatie'] = createAutorisatieSettingsFor(afnemerId);
    }

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    if(context.oAuth.enable){
        const result = await handleOAuthCustomRequest(accessToken, context.oAuth, afnemerId, url, verb, '{}');
        context.response = result.response;
        accessToken = result.accessToken;
    }
    else {
        context.response = await handleCustomBevragenRequest(url, verb, undefined, createBasicAuthorizationHeader(afnemerId, gemeenteCode), '{}');
    }
}

When(/^bewoning wordt gezocht met een '(.*)' aanroep$/, async function(verb){
    this.context.proxyAanroep = true;

    await handleCustomRequest(this.context, verb);
});

When(/^gba bewoning wordt gezocht met een '(.*)' aanroep$/, async function(verb){
    this.context.proxyAanroep = false;

    await handleCustomRequest(this.context, verb);
});

function createBewoning(dataTable) {
    let bewoning = createObjectFrom(dataTable, true);
    const match = bewoning.periode.match(/^(?<datumVan>[\d-]*) tot (?<datumTot>[\d-]*)$/);
    if(match) {
        bewoning.periode = match.groups;
    }

    bewoning.bewoners = [];
    bewoning.mogelijkeBewoners = [];

    return bewoning;
}

Then(/^heeft de response een bewoning met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(createBewoning(dataTable));
});

Then(/^heeft de bewoning geen bewoners en geen mogelijke bewoners$/, function () {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoners toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);
});

Then(/^heeft de bewoning een bewoner met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om bewoners toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    expectedBewoning.bewoners.push(createObjectFrom(dataTable, true));
});

Then(/^heeft de bewoner de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om bewoner gegevens aan te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    let expectedBewoner = expectedBewoning.bewoners.at(-1);
    should.exist(expectedBewoner, `geen bewoner om gegevens aan toe te voegen. Gebruik de stap 'En heeft de bewoning een bewoner met de volgende gegevens' om een verwachte bewoner te definieren`);

    expectedBewoner[gegevensgroep] = createObjectFrom(dataTable, true);
});

Then(/^heeft de bewoning bewoners met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om bewoners toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    expectedBewoning.bewoners = createObjectArrayFrom(dataTable, true);
});

Then(/^heeft de bewoning mogelijke bewoners met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om mogelijke bewoners toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    expectedBewoning.mogelijkeBewoners = createObjectArrayFrom(dataTable, true);
});

Then(/^heeft de bewoning een mogelijke bewoner met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om mogelijke bewoners toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    expectedBewoning.mogelijkeBewoners.push(createObjectFrom(dataTable, true));
});

Then(/^heeft de persoon met burgerservicenummer '(.*)' de volgende '(.*)' gegevens$/, async function (burgerservicenummer, tabelNaam, dataTable) {
    this.context.verifyResponse = false;
    const sqlData = dataTable.hashes()[0];

    const persoonSqlData = this.context.sqlData.find(s => s.persoon?.at(0).find(a => a[0] == 'burger_service_nr' && a[1] == burgerservicenummer));
    should.exist(persoonSqlData);

    const pl_id = Number(persoonSqlData['inschrijving'][0].find(e => e[0] === 'pl_id')[1]);
    should.exist(pl_id);

    if (sqlData !== undefined && pool !== undefined) {
        let res;
        let client;
        try {
            let tableName = tableNameMap.get(tabelNaam);
            if(tableName === undefined) {
                tableName = tabelNaam;
            }
            const sql = `SELECT * FROM public.${tableName} WHERE pl_id=${pl_id} ORDER BY request_datum DESC LIMIT 1`;

            client = await pool.connect();
            res = await client.query(sql);
        }
        catch(ex) {
            console.log(ex);
        }
        finally {
            if(client !== undefined){
                client.release();
            }
        }

        should.exist(res);
        res.rows.length.should.equal(1, `Geen ${tabelNaam} gegevens gevonden voor persoon met burgerservicenummer ${burgerservicenummer}`);

        const actual = res.rows[0];
        Object.keys(sqlData).forEach(function(key) {
            actual[key].split(' ').should.have.members(sqlData[key].split(' '), `${actual[key]} !== ${sqlData[key]}`);
        });
    }
});

Then(/^is voor de geauthenticeerde consumer '(\d*)' protocollering regels vastgelegd$/, async function (aantal) {
    this.context.verifyResponse = false;

    const tabelNaam = 'protocollering';
    const afnemerId = this.context.afnemerId ?? this.context.oAuth?.clients[0].afnemerID;

    if (pool !== undefined) {
        let res;
        let client;
        try {
            let tableName = tableNameMap.get(tabelNaam);
            if(tableName === undefined) {
                tableName = tabelNaam;
            }
            const sql = `SELECT COUNT(*) FROM public.${tableName} WHERE afnemer_code=${afnemerId}`;

            client = await pool.connect();
            res = await client.query(sql);
        }
        catch(ex) {
            console.log(ex);
        }
        finally {
            if(client !== undefined){
                client.release();
            }
        }

        should.exist(res);
        res.rows.length.should.equal(1, `Geen ${tabelNaam} gegevens gevonden voor afnemer met code ${afnemerId}`);

        const actual = res.rows[0];
        actual['count'].should.equal(aantal);
    }
});

Then(/^heeft de response (\d*) (?:bewoning|bewoningen)$/, function (aantal) {
    this.context?.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.bewoningen;

    should.exist(actual);
    actual.length.should.equal(Number(aantal), `aantal bewoningen in response is ongelijk aan ${aantal}\nBewoningen: ${JSON.stringify(actual, null, '\t')}`);
});

Then(/^heeft de response een bewoning met (\d*) bewoners en (\d*) mogelijke bewoners$/, function (aantalBewoners, aantalMogelijkeBewoners) {
    this.context?.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.bewoningen;
    should.exist(actual);

    const actualBewoning = actual.at(-1);
    should.exist(actualBewoning.bewoners, `geen bewoners array om bewoners te kunnen tellen. response:\n${JSON.stringify(actual, null, '\t')}`);
    actualBewoning.bewoners.length.should.equal(Number(aantalBewoners), `aantal bewoners in response is ongelijk aan ${aantalBewoners}\nBewoning: ${JSON.stringify(actualBewoning, null, '\t')}`);
    should.exist(actualBewoning.mogelijkeBewoners, `geen mogelijkeBewoners array om mogelijke bewoners te kunnen tellen. response:\n${JSON.stringify(actual, null, '\t')}`);
    actualBewoning.mogelijkeBewoners.length.should.equal(Number(aantalMogelijkeBewoners), `aantal mogelijke bewoners in response is ongelijk aan ${aantalMogelijkeBewoners}\nBewoning: ${JSON.stringify(actualBewoning, null, '\t')}`);
});

Then(/^heeft de response een object met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    this.context.expected = createObjectFrom(dataTable, this.context.proxyAanroep);
});

Then(/^heeft het object de volgende '(.*)' gegevens$/, function (gegevensgroep, dataTable) {
    this.context.expected[gegevensgroep] = dataTable.hashes();
});

After({tags: 'not @fout-case'}, async function() {
    if (this.context.verifyResponse === undefined ||
        !this.context.verifyResponse) {
        return;
    }

    this.context.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data.bewoningen !== undefined
        ? stringifyValues(this.context.response.data.bewoningen)
        : [];
    const expected = this.context.expected !== undefined
        ? this.context.expected
        : [];

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

After({tags: '@fout-case'}, async function() {
    this.context.response.status.should.not.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const headers = this.context?.response?.headers;
    should.exist(headers, 'no response headers found');

    const header = headers["content-type"];
    should.exist(header, `no header found with name 'content-type'. Response headers: ${headers}`);
    header.should.contain('application/problem+json', "no 'content-type' header found with value: 'application/problem+json'");

    const actual = this.context?.response?.data !== undefined
        ? stringifyValues(this.context.response.data)
        : {};
    const expected = this.context.expected;

    actual.should.deep.equalInAnyOrder(expected, `actual: ${JSON.stringify(actual, null, '\t')}\nexpected: ${JSON.stringify(expected, null, '\t')}`);
});

Before({tags: '@autorisatie'}, async function() {
    this.context.createDefaultAutorisation = false;
});

Before(function() {
    if(this.context.sql.useDb && pool === undefined && this.context.stapDocumentatie) {
        pool = new Pool(this.context.sql.poolConfig);
        logSqlStatements = this.context.sql.logStatements;
    }
});

After(async function() {
    if (pool === undefined ||
        !this.context.sql.cleanup ||
        noSqlData(this.context.sqlData)) {
        return;
    }

    let deleteIndividualRecords = this.context.sql.deleteIndividualRecords;
    if(deleteIndividualRecords === undefined) {
        deleteIndividualRecords = true;
    }

    await rollbackSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements, deleteIndividualRecords);
});
