const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
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

let pool = undefined;
let logSqlStatements = false;
let accessToken = undefined;

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

Given(/^de '(\w*)' heeft de volgende '(\w*)' gegevens$/, function (_, gegevensgroep, dataTable) {
    if(gegevensgroep === 'adres') {
        should.fail(`deprecated. Gebruik de stap: "Gegeven een adres heeft de volgende gegevens" om eerst het adres te specificeren`);
    }
    else {
        let sqlData = this.context.sqlData.at(-1);

        if(sqlData[`${gegevensgroep}`] === undefined) {
            sqlData[`${gegevensgroep}`] = [];
        }
        sqlData[`${gegevensgroep}`].push(createArrayFrom(dataTable, columnNameMap));
    }
});

function wijzigRelatie(relatie, dataTable) {
    should.not.equal('verblijfplaats', `deprecated. Gebruik de nieuwe stap: "En de persoon is vervolgens ingeschreven op het adres met '<element naam>' '<waarde>' met de volgende gegevens"`)

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

Given(/^adres '(.*)' is op '(.*)' gewijzigd naar de volgende gegevens$/, function (adresId, ingangsdatum, dataTable) {
    let sqlData = this.context.sqlData.at(0);

    const nieuwAdresIndex = Object.keys(sqlData['adres']).length;
    const nieuwAdresData = createArrayFrom(dataTable, columnNameMap);
    sqlData['adres'][nieuwAdresIndex + 1 + ''] = {
        index: nieuwAdresIndex,
        data: nieuwAdresData
    };

    const adresIndex = this.context.sqlData.at(0).adres[adresId]?.index;
    should.exist(adresIndex, `geen adres gevonden met id '${adresId}'`);

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
                [ 'aangifte_adreshouding_oms', 'W' ]
            ];
            if(nieuwGemeenteCode !== undefined) {
                nieuwVerblijfplaatsData.push([ 'inschrijving_gemeente_code', nieuwGemeenteCode[1] ]);
            }

            elem.verblijfplaats.push(nieuwVerblijfplaatsData);
        }
    });
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

async function handleRequest(context, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth?.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    const heeftAutorisatieSettings = context.sqlData.filter(s => s['autorisatie'] !== undefined).length > 0;
    if(!heeftAutorisatieSettings){
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
    if(!heeftAutorisatieSettings){
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

Then(/^heeft de response geen bewoningen$/, function () {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
});

function createBewoning(dataTable) {
    let bewoning = createObjectFrom(dataTable, true);
    const match = bewoning.periode.match(/^(?<datumVan>[\d-]*) tot (?<datumTot>[\d-]*)$/);
    if(match) {
        bewoning.periode = match.groups;
    }

    if(bewoning.type === 'Bewoning') {
        bewoning.bewoningPeriodes = [];
    }

    return bewoning;
}

function createBewoningPeriode(van, tot) {
    return {
        periode: { datumVan: van, datumTot: tot },
        bewoners: [],
        mogelijkeBewoners: []
    }
}

function getBewoningPeriode(bewoning, van, tot) {
    let bewoningPeriode = bewoning.bewoningPeriodes.find(p => p.periode.datumVan === van &&
                                                              p.periode.datumTot === tot);

    if(bewoningPeriode === undefined) {
        bewoningPeriode = createBewoningPeriode(van, tot);

        bewoning.bewoningPeriodes.push(bewoningPeriode); 
    }

    return bewoningPeriode;
}

Then(/^heeft de response een bewoning met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(createBewoning(dataTable));
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' geen bewoners$/, function (van, tot) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoningPeriode toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    expectedBewoning.bewoningPeriodes.push(createBewoningPeriode(van, tot));
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' een bewoner met de volgende gegevens$/, function (van, tot, dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoningPeriode toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    let expectedBewoningPeriode = getBewoningPeriode(expectedBewoning, van, tot);

    expectedBewoningPeriode.bewoners.push(createObjectFrom(dataTable, true));
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' bewoners met de volgende gegevens$/, function (van, tot, dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoningPeriode toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    let expectedBewoningPeriode = getBewoningPeriode(expectedBewoning, van, tot);

    expectedBewoningPeriode.bewoners = createObjectArrayFrom(dataTable, true);
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' een mogelijke bewoner met de volgende gegevens$/, function (van, tot, dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoningPeriode toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    let expectedBewoningPeriode = getBewoningPeriode(expectedBewoning, van, tot);

    expectedBewoningPeriode.mogelijkeBewoners.push(createObjectFrom(dataTable, true));
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' mogelijke bewoners met de volgende gegevens$/, function (van, tot, dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoningPeriode toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    let expectedBewoningPeriode = getBewoningPeriode(expectedBewoning, van, tot);

    expectedBewoningPeriode.mogelijkeBewoners = createObjectArrayFrom(dataTable, true);
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

Then(/^heeft de response (\d*) (?:bewoning|bewoningen)$/, function (aantal) {
    this.context?.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.bewoningen;

    should.exist(actual);
    actual.length.should.equal(Number(aantal), `aantal bewoningen in response is ongelijk aan ${aantal}\nBewoningen: ${JSON.stringify(actual, null, '\t')}`);
});

Then(/^heeft de response een bewoning met een bewoningPeriode '([\d-]*) tot ([\d-]*)' met (\d*) bewoners$/, function (van, tot, aantal) {
    this.context?.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.bewoningen;
    should.exist(actual);

    const actualBewoning = actual.at(-1);
    const bewoningPeriode = getBewoningPeriode(actualBewoning, van, tot);
    should.exist(bewoningPeriode);
    should.exist(bewoningPeriode.bewoners, `geen bewoners array om bewoners te kunnen tellen. response:\n${JSON.stringify(actual, null, '\t')}`);
    bewoningPeriode.bewoners.length.should.equal(Number(aantal), `aantal bewoners in response is ongelijk aan ${aantal}\nBewoningPeriode: ${JSON.stringify(bewoningPeriode, null, '\t')}`);
});

Then(/^heeft de response een bewoning met een bewoningPeriode '([\d-]*) tot ([\d-]*)' met (\d*) mogelijke bewoners$/, function (van, tot, aantal) {
    this.context?.response?.status?.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data?.bewoningen;
    should.exist(actual);

    const actualBewoning = actual.at(-1);
    const bewoningPeriode = getBewoningPeriode(actualBewoning, van, tot);
    should.exist(bewoningPeriode);
    should.exist(bewoningPeriode.mogelijkeBewoners, `geen mogelijkeBewoners array om mogelijke bewoners te kunnen tellen. response:\n${JSON.stringify(actual, null, '\t')}`);
    bewoningPeriode.mogelijkeBewoners.length.should.equal(Number(aantal), `aantal bewoners in response is ongelijk aan ${aantal}\nBewoningPeriode: ${JSON.stringify(bewoningPeriode, null, '\t')}`);
});

Then(/^heeft de bewoningPeriode de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    let expectedBewoning = this.context.expected?.at(-1);
    should.exist(expectedBewoning, `geen bewoning om de bewoningPeriode toe te voegen. Gebruik de stap 'Dan heeft de response een bewoning met de volgende gegevens' om een verwachte bewoning te definieren`);

    let expectedBewoningPeriode = expectedBewoning.bewoningPeriodes.at(-1);
    should.exist(expectedBewoningPeriode, `geen bewoningPeriode om velden toe te voegen.`);

    Object.assign(expectedBewoningPeriode, createObjectFrom(dataTable, true));
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

    await rollbackSqlStatements(this.context.sqlData, pool, tableNameMap, logSqlStatements);
});
