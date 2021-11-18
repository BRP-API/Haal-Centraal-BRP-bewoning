#language: nl

Functionaliteit: Bewoninghistorie parameters validatie

Rule: fields parameter is verplicht

    Scenario: geen fields parameter opgegeven
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde           |
        | adresseerbaarObjectIdentificatie | 0518010000412416 |
        Dan is de response
        '''
        {
            "title": "Geen verplichte zoek parameter opgegeven",
            "detail": "fields parameter is verplicht ten behoeve van dataminimalisatie"
            "status": 400,
            "code": "paramsRequired",
            "instance": "/bewoningenhistorie?adresseerbaarObjectIdentificatie=0518010000412416",
            "invalidParams": [
                {
                    "name": "fields",
                    "code": "required",
                    "reason": "Parameter is verplicht."
                }
            ]
        }
        '''

Rule: adresseerbaarObjectIdentificatie of burgerservicenummer parameter zijn verplicht

    Scenario: burgerservicenummer of adresseerbaarobjectidentificatie parameter is niet opgegeven
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam   | waarde     |
        | fields | bewoningen |
        Dan is de response
        '''
        {
            "title": "Geen verplichte zoek parameter opgegeven",
            "detail": "Geef minimaal burgerservicenummer of adresseerbaarobjectidentificatie als filter op"
            "status": 400,
            "code": "paramsRequired",
            "instance": "/bewoningenhistorie?fields=bewoningen"
        }
        '''

Rule: opgeven van datumVan en/of datumTotEnMet parameters en peildatum parameter is niet toegestaan

    Abstract Scenario: <parameters> parameters zijn opgegeven
        Als de endpoint '/bewoningenhistorie' met query string '<query string>&burgerservicenummer=99999XXXX&fields=bewoningen' wordt aangeroepen
        Dan is de response
        '''
        {
            "title": "Eén of meerdere parameters zijn niet correct.",
            "detail": "<parameters> mogen niet samen als filter worden opgegeven"
            "status": 400,
            "code": "unsupportedParamsCombi",
            "instance": "/bewoningenhistorie?<query string>&burgerservicenummer=99999XXXX&fields=bewoningen"
        }
        '''

        Voorbeelden:
        | query string                                                      | parameters                           |
        | datumVan=2020-01-01&datumTotEnMet=2021-01-01&peildatum=2020-08-31 | datumVan, datumTotEnMet en peildatum |
        | datumVan=2020-01-01&peildatum=2020-08-31                          | datumVan en peildatum                |
        | datumTotEnMet=2021-01-01&peildatum=2020-08-31                     | datumTotEnMet en peildatum           |

Rule: datumVan, datumTotEnMet en peildatum parameters mogen niet in de toekomst liggen

    Abstract Scenario: <parameter> parameter is een datum in de toekomst
        Gegeven de datum van vandaag is 2021-11-18
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde     |
        | fields              | bewoningen |
        | burgerservicenummer | 99999XXXX  |
        | <parameter>         | 2021-11-19 |
        Dan is de response
        '''
        {
            "title": "Eén of meerdere parameters zijn niet correct.",
            "status": 400,
            "instance": "/bewoningenhistorie?burgerservicenummer=99999XXXX&fields=bewoningen&<parameter>=2021-11-19",
            "invalidParams": [
                {
                    "name": "<parameter>",
                    "code": "invalidValue",
                    "reason": "Parameter mag geen datum in de toekomst zijn."
                }
            ]
        }
        '''

        Voorbeelden:
        | parameter     |
        | datumVan      |
        | datumTotEnMet |
        | peildatum     |

Rule: datumVan moet voor datumTotEnMet liggen

    Scenario: datumVan ligt na datumTotEnMet
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde           |
        | adresseerbaarobjectidentificatie | 0518010000781379 |
        | datumVan                         | 2020-08-02       |
        | datumTotEnMet                    | 2020-08-01       |
        | fields                           | bewoningen       |
        Dan is de response
        '''
        {
            "title": "Eén of meerdere parameters zijn niet correct.",
            "status": 400,
            "instance": "/bewoningenhistorie?datumVan=2020-08-02&datumTotEnMet=2020-08-01&fields=bewoningen",
            "invalidParams": [
                "name": "datumVan",
                "code": "range",
                "reason": "datumVan mag niet na datumTotEnMet liggen"
            ]
        }
        '''

Rule: datumVan en datumTotEnMet zijn standaard gelijk aan de datum van vandaag

    Scenario: datumVan is niet opgegeven en datumTotEnMet is opgegeven
        Gegeven datum van vandaag is 2021-11-17
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde           |
        | adresseerbaarobjectidentificatie | 0518010000781379 |
        | datumTotEnMet                    | 2020-08-01       |
        | fields                           | bewoningen       |
        Dan is de response
        '''
        {
            "title": "Eén of meerdere parameters zijn niet correct.",
            "status": 400,
            "instance": "/bewoningenhistorie?adresseerbaarobjectidentificatie=0518010000781379&datumTotEnMet=2020-08-01&fields=bewoningen",
            "invalidParams": [
                "name": "datumVan",
                "code": "range",
                "reason": "datumVan (standaard: vandaag) mag niet na datumTotEnMet liggen"
            ]
        }
        '''
