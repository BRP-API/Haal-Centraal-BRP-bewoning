const { toDateOrString } = require('./calcDate');

const tableNameMap = new Map([

    ['adres', 'lo3_adres'],
    ['autorisatie', 'lo3_autorisatie'],
    ['gezagsverhouding', 'lo3_pl_gezagsverhouding'],
    ['inschrijving', 'lo3_pl'],
    ['persoon', 'lo3_pl_persoon' ],
    ['protocollering', 'haalcentraal_vraag'],
    ['verblijfplaats', 'lo3_pl_verblijfplaats'],

]);

const columnNameMap = new Map([

    ['gemeente van inschrijving (09.10)', 'inschrijving_gemeente_code'],

    ['datum aanvang adreshouding (10.30)', 'adreshouding_start_datum'],

    ['straatnaam (11.10)', 'straat_naam'],
    ['identificatiecode verblijfplaats (11.80)', 'verblijf_plaats_ident_code'],
    ['identificatiecode nummeraanduiding (11.90)', 'nummer_aand_ident_code'],

    ['locatiebeschrijving (12.10)', 'locatie_beschrijving'],

    ['indicatie gezag minderjarige (32.10)', 'minderjarig_gezag_ind'],

    ['aanduiding uitgesloten kiesrecht (38.10)', 'kiesrecht_uitgesl_aand'],

    ['datum opschorting bijhouding (67.10)', 'bijhouding_opschort_datum' ],
    ['reden opschorting bijhouding (67.20)', 'bijhouding_opschort_reden'],

    ['indicatie geheim (70.10)', 'geheim_ind'],

    ['aanduiding in onderzoek (83.10)', 'onderzoek_gegevens_aand' ],
    ['datum ingang onderzoek (83.20)', 'onderzoek_start_datum' ],
    ['datum einde onderzoek (83.30)', 'onderzoek_eind_datum' ],

    ['gemeentecode (92.10)', 'gemeente_code'],

    ['Rubrieknummer ad hoc (35.95.60)', 'ad_hoc_rubrieken'],
    ['Medium ad hoc (35.95.67)', 'ad_hoc_medium'],
    ['Datum ingang (35.99.98)', 'tabel_regel_start_datum'],

]);

function createRequestBody(dataTable) {
    let requestBody = {};
    dataTable.hashes()
            .filter(function(param) {
                return !param.naam.startsWith("header:");
            })
            .forEach(function(param) {
                if(["burgerservicenummer",
                    "burgerservicenummer (als string)",
                    "fields",
                    "fields (als string)"].includes(param.naam)) {
                    if(param.naam === 'fields (als string)') {
                        requestBody['fields'] = param.waarde;
                    }
                    else if(param.naam === 'burgerservicenummer (als string)') {
                        requestBody['burgerservicenummer'] = param.waarde;
                    }
                    else if(param.waarde === '') {
                        requestBody[param.naam] = [];
                    }
                    else if(param.waarde === '(131 maal aNummer)') {
                        requestBody[param.naam] = [];
                        for(let count=0; count<=131; count++) {
                            requestBody[param.naam].push('aNummer');
                        }
                    }
                    else {
                        requestBody[param.naam] = param.waarde.split(',');
                    }
                }
                else {
                    requestBody[param.naam] = toDateOrString(param.waarde, true);
                }
            });

    return requestBody;
}

function createBasicAuthorizationHeader(afnemerId, gemeenteCode) {
    return [
        { "naam": "Authorization", "waarde": "Basic " + Buffer.from(`${afnemerId}|${gemeenteCode}:tempsolution!`).toString('base64') }
    ]
}

module.exports = {
    tableNameMap,
    columnNameMap,
    // createAutorisatieSettingsFor,
    createRequestBody,
    createBasicAuthorizationHeader,
    // createAdresseringBinnenlandAutorisatieSettingsFor,
    // createVerblijfplaatsBinnenlandAutorisatieSettingsFor
}
