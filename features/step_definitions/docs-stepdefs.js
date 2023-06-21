const { Given, When, Then, setWorldConstructor, Before, After } = require('@cucumber/cucumber');
const deepEqualInAnyOrder = require('deep-equal-in-any-order');
const should = require('chai').use(deepEqualInAnyOrder).should();
const { noSqlData, executeSqlStatements, rollbackSqlStatements, insertIntoPersoonlijstStatement, insertIntoAdresStatement, insertIntoStatement } = require('./postgresqlHelpers.js');
const { tableNameMap, columnNameMap, createAutorisatieSettingsFor, createRequestBody, createBasicAuthorizationHeader, createAdresseringBinnenlandAutorisatieSettingsFor, createVerblijfplaatsBinnenlandAutorisatieSettingsFor } = require('./gba.js');

Before({tags: 'not @stap-documentatie'}, async function() {
    this.context.stapDocumentatie = true;
});

Given(/^de (\d)e '(.*)' statement heeft als resultaat '(\d*)'$/, function (index, statement, result) {
    if(this.context.sqlDataIds == undefined) {
        this.context.sqlDataIds = {
            adresIds: [],
            plIds:[]
        };
    }

    let ids = this.context.sqlDataIds;

    if(statement.includes('lo3_pl')) {
        ids.plIds[index-1] = Number(result);
    }
    if(statement.includes('lo3_adres')) {
        ids.adresIds[index-1] = Number(result);
    }
});

Given(/^de response body is gelijk aan$/, function (docString) {
    this.context.response = {
        data: JSON.parse(docString)
    };
});

function groupeerQueriesInDataTableInQueriesPerEntiteit(dataTable) {
    let retval = [];

    let lastCategorie;
    let index = 0;
    dataTable.hashes().forEach(function(hash) {
        if(hash.stap !== undefined && hash.stap !== '') {
            // index is gevuld => nieuw entiteit
            index = Number(hash.stap)-1;
            retval[index] = {};
        }

        let obj = retval[index];
        if(hash.categorie !== '') {
            // key is gevuld => nieuw categorie binnen entiteit, query statement hoort bij deze categorie
            obj[hash.categorie] = [ hash ];
            lastCategorie = hash.categorie;
        }
        else {
            // key is niet gevuld => query statement hoort bij laatste categorie
            obj[lastCategorie].push(hash);
        }
    });

    return retval;
}

Then(/^zijn de gegenereerde SQL statements$/, function(dataTable) {
    const sqlDatas = this.context.sqlData;
    const sqlDataIds = this.context.sqlDataIds;
    const expected = groupeerQueriesInDataTableInQueriesPerEntiteit(dataTable);

    let currentPlIndex;
    for(const expectedEntiteit of expected) {
        let currentStep;
        for(const categorie of Object.keys(expectedEntiteit)) {
            expectedEntiteit[categorie].forEach(function(exp, index) {

                if(exp.stap !== undefined && exp.stap !== '') {
                    currentStep = Number(exp.stap) - 1;
                }

                const actual = sqlDatas[currentStep][categorie][index];

                let statement;
                switch(categorie) {
                    case 'adres':
                        statement = insertIntoAdresStatement(actual);
                        break;
                    case 'inschrijving':
                        statement = insertIntoPersoonlijstStatement(actual);
                        currentPlIndex = currentPlIndex === undefined ? 0 : currentPlIndex+1;
                        break;
                    case 'verblijfplaats':
                        let adresIdElem = actual.find(ee => ee[0] === 'adres_id');
                        adresIdElem[1] = sqlDataIds.adresIds[Number(adresIdElem[1])]+'';
                        statement = insertIntoStatement(categorie, [
                            ['pl_id', sqlDataIds.plIds[currentPlIndex]+''],
                        ].concat(actual), tableNameMap);
                        break;
                    default:
                        const name = categorie.replace(/-\d$/, "");
                        statement = insertIntoStatement(name, [
                            ['pl_id', sqlDataIds.plIds[currentPlIndex]+'']
                        ].concat(actual), tableNameMap);
                        break;
                }

                statement.text.should.equal(exp.text);
                statement.values.should.deep.equalInAnyOrder(exp.values.split(','), `${exp.key}: ${statement.values} != ${exp.values}`);
            });
        }
    }
});
