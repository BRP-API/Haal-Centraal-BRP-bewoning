const { World } = require('./world');
const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const { createObjectFrom, createObjectArrayFrom } = require('./dataTable2Object.js');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { Pool } = require('pg');
const { noSqlData, executeSqlStatements, rollbackSqlStatements, insertIntoPersoonlijstStatement, insertIntoAdresStatement, insertIntoStatement } = require('./postgresqlHelpers.js');
const { createCollectieDataFromArray, createArrayFrom, createVoorkomenDataFromArray } = require('./dataTable2Array.js');
const { postBevragenRequestWithBasicAuth, handleOAuthRequest } = require('./handleRequest.js');
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

Given(/^een adres heeft de volgende gegevens$/, function (dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }
    this.context.sqlData.push({});

    let sqlData = this.context.sqlData.at(-1);

    sqlData['adres'] = [ createArrayFrom(dataTable, columnNameMap) ];
});

function bepaalAdresIndex(sqlData, veldNaam, veldWaarde) {
    let adresIndex;

    sqlData.forEach(function(sqlData, index) {
        if(sqlData['adres'] !== undefined) {
            const propertyName = columnNameMap.get(veldNaam);

            sqlData['adres'].forEach(function(data) {
                if(data.find(el => el[0] === propertyName && el[1] === veldWaarde) !== undefined) {
                    adresIndex = index;
                }
            });
        }
    });

    return adresIndex;
}

Given(/^de persoon met burgerservicenummer '(\d*)' is ingeschreven op het adres met '(.*)' '(.*)' met de volgende gegevens$/, function (burgerservicenummer, veldNaam, veldWaarde, dataTable) {
    if(this.context.sqlData === undefined) {
        this.context.sqlData = [];
    }

    let adresIndex = bepaalAdresIndex(this.context.sqlData, veldNaam, veldWaarde);
    should.exist(adresIndex, `geen adres gevonden met '${veldNaam}' gelijk aan '${veldWaarde}'`);

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

Given(/^de persoon is vervolgens ingeschreven op het adres met '(.*)' '(.*)' met de volgende gegevens$/, function (veldNaam, veldWaarde, dataTable) {

    let adresIndex = bepaalAdresIndex(this.context.sqlData, veldNaam, veldWaarde);

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

async function handleRequest(context, dataTable) {
    if(context.sqlData === undefined) {
        context.sqlData = [{}];
    }

    const afnemerId = context.afnemerId ?? context.oAuth?.clients[0].afnemerID;
    const gemeenteCode = context.gemeenteCode ?? "800";
    const url = context.proxyAanroep ? context.proxyUrl : context.apiUrl;

    await executeSqlStatements(context.sqlData, pool, tableNameMap, logSqlStatements);

    context.response = await postBevragenRequestWithBasicAuth(url, createBasicAuthorizationHeader(afnemerId, gemeenteCode), dataTable);
}

When(/^bewoning wordt gezocht met de volgende parameters$/, function (dataTable) {
});

When(/^gba bewoning wordt gezocht met de volgende parameters$/, async function (dataTable) {
    this.context.proxyAanroep = false;

    await handleRequest(this.context, dataTable);
});

Then(/^heeft de response een bewoning met de volgende gegevens$/, function (dataTable) {
    this.context.verifyResponse = true;

    let expected = createObjectFrom(dataTable, true);
    const match = expected.periode.match(/^(?<datumVan>[\d-]*) tot (?<datumTot>[\d-]*)$/);
    if(match) {
        expected.periode = match.groups;
    }

    if(this.context.expected === undefined) {
        this.context.expected = [];
    }
    this.context.expected.push(expected);
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' een bewoner met de volgende gegevens$/, function (van, tot, dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }
    let expectedBewoning = this.context.expected.at(-1);

    if(expectedBewoning.bewoningPeriodes === undefined) {
        expectedBewoning.bewoningPeriodes = [
            {
                periode: { datumVan: van, datumTot: tot },
                bewoners: []
            }
        ];
    }

    let expectedBewoningPeriode = expectedBewoning.bewoningPeriodes.find(p => p.periode.datumVan === van && p.periode.datumTot === tot);
    if(expectedBewoningPeriode === undefined) {
        expectedBewoningPeriode = {
            periode: { datumVan: van, datumTot: tot },
            bewoners: []
        };
        expectedBewoning.bewoningPeriodes.push(expectedBewoningPeriode); 
    }

    expectedBewoningPeriode.bewoners.push(createObjectFrom(dataTable, true));
});

Then(/^heeft de bewoning voor de bewoningPeriode '([\d-]*) tot ([\d-]*)' bewoners met de volgende gegevens$/, function (van, tot, dataTable) {
    this.context.verifyResponse = true;

    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }
    let expectedBewoning = this.context.expected.at(-1);

    if(expectedBewoning.bewoningPeriodes === undefined) {
        expectedBewoning.bewoningPeriodes = [
            {
                periode: { datumVan: van, datumTot: tot },
                bewoners: []
            }
        ];
    }

    let expectedBewoningPeriode = expectedBewoning.bewoningPeriodes.find(p => p.periode.datumVan === van && p.periode.datumTot === tot);
    if(expectedBewoningPeriode === undefined) {
        expectedBewoningPeriode = {
            periode: { datumVan: van, datumTot: tot },
            bewoners: []
        };
        expectedBewoning.bewoningPeriodes.push(expectedBewoningPeriode); 
    }

    expectedBewoningPeriode.bewoners = createObjectArrayFrom(dataTable, true);
});

Then(/^heeft de bewoning voor de bewoningPeriode '(.*)' een mogelijke bewoner met de volgende gegevens$/, function (periode, dataTable) {
});

Then(/^heeft de bewoning voor de bewoningPeriode '(.*)' geen bewoners$/, function (periode) {
});

Then(/^heeft de bewoner de volgende '(\w*)' gegevens$/, function (gegevensgroep, dataTable) {
    if(this.context.expected === undefined) {
        this.context.expected = [ {} ];
    }

    const expectedBewoning = this.context.expected.at(-1);

    const expectedBewoningPeriode = expectedBewoning.bewoningPeriodes.at(-1);

    let expectedBewoner = expectedBewoningPeriode.bewoners.at(-1);

    expectedBewoner[gegevensgroep] = createObjectFrom(dataTable);
});

After({tags: 'not @fout-case'}, async function() {
    if (this.context.verifyResponse === undefined ||
        !this.context.verifyResponse) {
        return;
    }

    this.context.response?.status.should.equal(200, `response body: ${JSON.stringify(this.context.response.data, null, '\t')}`);

    const actual = this.context?.response?.data.bewoningen !== undefined
        ? stringifyValues(this.context.response.data.bewoningen)
        : [];
    const expected = this.context.expected !== undefined
        ? this.context.expected
        : [];

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
