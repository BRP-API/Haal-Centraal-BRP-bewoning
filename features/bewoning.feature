# language: nl

Functionaliteit: Bewoning

    Als medewerker
    Wil ik bevragen welke personen op een verblijfplaats wonen/hebben gewoond

    Als medewerker
    Wil ik bevragen welke personen op de verblijfplaatsen van een persoon wonen/hebben gewoond

    Als medewerker
    Wil ik bevragen welke personen op hetzelfde moment op een verblijfplaats hebben gewoond

Rule: zoeken met adresseerbaarObjectIdentificatie, datumVan en datumTotEnMet retourneert de personen die tussen datumVan en datumTotEnMet op het adresseerbaarobject een adreshouding hebben (gehad)

    Scenario: <scenario titel>
        Gegeven adresseerbaarobject met identificatie '0518010000412416' heeft de volgende bewoners
        | burgerservicenummer | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 2019-08-01           | 2020-10-01       |
        | 99999YYYY           | 2020-04-01           | 2020-09-01       |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde                                                     |
        | adresseerbaarObjectIdentificatie | 0518010000412416                                           |
        | datumVan                         | <datumVan>                                                 |
        | datumTotEnMet                    | <datumTotEnMet>                                            |
        | fields                           | bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "<datumVan>",
                                "tot": "<datum tot>"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999YYYY"
                                },
                            ]
                        }
                    ]
                }
            ]
        }
        '''

        Voorbeelden:
        | datumVan   | datumTotEnMet | datum tot  | scenario titel                                   |
        | 2019-01-01 | 2020-12-31    | 2021-01-01 | zoek periode overlapt adreshouding periode       |
        | 2019-10-01 | 2020-07-31    | 2020-08-01 | zoek periode overlapt deels adreshouding periode |

Rule: zoeken met burgerservicenummer, datumVan en datumTotEnMet retourneert alle adresseerbaarobjecten waar de persoon met opgegeven burgerservicenummer tussen datumVan en datumTotEnMet een adreshouding heeft (gehad) + de personen die tussen datumVan en datumTotEnMet op dezelfde adresseerbaarobjecten een adreshouding hebben (gehad)

    Scenario: zoeken met burgerservicenummer: zoek periode overlap gedeeltelijk meerdere adreshouding periodes
        Gegeven de bewoners
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 0518010000412416                 | 2019-08-01           | 2020-10-01       |
        | 99999XXXX           | 0518010000781379                 | 2020-10-01           |                  |
        | 99999YYYY           | 0518010000412416                 | 2020-04-01           | 2020-09-01       |
        | 99999ZZZZ           | 0518010000781379                 | 2019-01-01           |                  |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde                                                     |
        | burgerservicenummer | 99999XXXX                                                  |
        | datumVan            | 2020-01-01                                                 |
        | datumTotEnMet       | 2020-12-31                                                 |
        | fields              | bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2020-10-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999YYYY"
                                }
                            ]
                        }
                    ]
                },
                {
                    "adresseerbaarObjectIdentificatie": "0518010000781379",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-10-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999ZZZZ"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

Rule: adreshouding periode van een bewoner geeft ALTIJD de periode aan dat een persoon op een adresseerbaarobject was/is ingeschreven

    Scenario: <scenario titel>
        Gegeven adresseerbaarobject met identificatie '0518010000412416' heeft de volgende adreshoudingen
        | burgerservicenummer | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 2019-08-01           | 2020-10-01       |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde                                                                                              |
        | adresseerbaarObjectIdentificatie | 0518010000412416                                                                                    |
        | datumVan                         | <datumVan>                                                                                          |
        | datumTotEnMet                    | <datumTotEnMet>                                                                                     |
        | fields                           | bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.adreshouding.periode |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "<datumVan>",
                                "tot": "<datum tot>"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX",
                                    "adreshouding": {
                                        "periode": {
                                            "aanvang": "2019-08-01",
                                            "tot": "2020-10-01"
                                        }
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

        Voorbeelden:
        | datumVan   | datumTotEnMet | datum tot  | scenario titel                                   |
        | 2019-08-01 | 2020-09-30    | 2020-10-01 | zoek periode is gelijk aan adreshouding periode  |
        | 2019-10-01 | 2019-12-31    | 2020-01-01 | adreshouding periode omvat zoek periode          |
        | 2019-01-01 | 2019-12-31    | 2020-01-01 | zoek periode overlapt deels adreshouding periode |

Rule: zoeken met toonBewoonsamenstelling splitst de bewoning periodes bij verandering in bewoon samenstelling

    Scenario: bewoon samenstelling op basis van adresseerbaarObjectIdentificatie
        Gegeven adresseerbaarobject met identificatie '0518010000412416' heeft de volgende bewoners
        | burgerservicenummer | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 2019-08-01           | 2020-10-01       |
        | 99999YYYY           | 2020-04-01           | 2020-09-01       |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde                                                                                      |
        | adresseerbaarObjectIdentificatie | 0518010000412416                                                                            |
        | datumVan                         | 2020-01-01                                                                                  |
        | datumTotEnMet                    | 2020-12-31                                                                                  |
        | toonBewoonSamenstelling          | true                                                                                        |
        | fields                           | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2020-04-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                }
                            ]
                        },
                        {
                            "periode": {
                                "van": "2020-04-01",
                                "tot": "2020-09-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999YYYY"
                                }
                            ]
                        },
                        {
                            "periode": {
                                "van": "2020-09-01",
                                "tot": "2020-10-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                }
                            ]
                        },
                        {
                            "periode": {
                                "van": "2020-10-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": []
                        }
                    ]
                }
            ]
        }
        '''

    Scenario: bewoon samenstelling op basis van burgerservicenummer
        Gegeven de bewoners
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 0518010000412416                 | 2019-08-01           | 2020-10-01       |
        | 99999XXXX           | 0518010000781379                 | 2020-10-01           |                  |
        | 99999YYYY           | 0518010000412416                 | 2020-04-01           | 2020-09-01       |
        | 99999ZZZZ           | 0518010000781379                 | 2019-01-01           |                  |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                    | waarde                                                                                      |
        | burgerservicenummer     | 99999XXXX                                                                                   |
        | datumVan                | 2020-01-01                                                                                  |
        | datumTotEnMet           | 2020-12-31                                                                                  |
        | toonBewoonSamenstelling | true                                                                                        |
        | fields                  | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2020-04-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                }
                            ]
                        },
                        {
                            "periode": {
                                "van": "2020-04-01",
                                "tot": "2020-09-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999YYYY"
                                }
                            ]
                        },
                        {
                            "periode": {
                                "van": "2020-09-01",
                                "tot": "2020-10-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                }
                            ]
                        }
                    ]
                },
                {
                    "adresseerbaarObjectIdentificatie": "0518010000781379",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-10-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999ZZZZ"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

Rule: zoeken met peildatum komt overeen met zoeken met datumVan en datumTotEnMet met dezelfde datum

    Scenario: zoek met peildatum
        Gegeven de bewoners
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 0518010000412416                 | 2019-08-01           | 2020-10-01       |
        | 99999XXXX           | 0518010000781379                 | 2020-10-01           |                  |
        | 99999YYYY           | 0518010000412416                 | 2020-04-01           | 2020-09-01       |
        | 99999ZZZZ           | 0518010000781379                 | 2019-01-01           |                  |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde                                                                                      |
        | burgerservicenummer | 99999XXXX                                                                                   |
        | peildatum           | 2020-08-31                                                                                  |
        | fields              | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-08-31",
                                "tot": "2020-09-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                },
                                {
                                    "burgerservicenummer": "99999YYYY"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

Rule: datumVan en datumTotEnMet zijn standaard gelijk aan de datum van vandaag
    Voor scenario 'datumVan is niet opgegeven en datumTotEnMet is opgegeven', zie bewoninghistorie-parameters-validatie.feature

    Scenario: datumVan is opgegeven en datumTotEnMet is niet opgegeven
        Gegeven de bewoner
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvang adreshouding | adreshouding tot |
        | 99999XXXX           | 0518010000412416                 | 2019-08-01           | 2020-10-01       |
        En datum vandaag is 2021-11-15
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde                                                                                      |
        | burgerservicenummer | 99999XXXX                                                                                   |
        | datumVan            | 2020-01-01                                                                                  |
        | fields              | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2021-11-16"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

    Scenario: datumVan en datumTotEnMet zijn niet opgegeven
        Gegeven de bewoner
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvang adreshouding | adreshouding tot |
        | 99999ZZZZ           | 0518010000781379                 | 2019-01-01           |                  |
        En datum vandaag is 2021-11-15
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde                                                                                      |
        | burgerservicenummer | 99999ZZZZ                                                                                   |
        | fields              | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000781379",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2021-11-15",
                                "tot": "2021-11-16"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999ZZZZ"
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

Rule: geen adreshouding in een periode = geen bewoners in de periode

    Scenario: geen adreshoudingen in de gehele zoek periode
        Gegeven adresseerbaarobject met identificatie '0599010000228162' heeft de volgende adreshoudingen
        | burgerservicenummer | aanvang    | tot        |
        | 99999AAAA           | 2019-01-01 | 2020-01-01 |
        | 99999BBBB           | 2020-04-01 |            |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde                                                                                                                       |
        | adresseerbaarobjectidentificatie | 0599010000228162                                                                                                             |
        | datumVan                         | 2020-01-01                                                                                                                   |
        | datumTotEnMet                    | 2020-03-31                                                                                                                   |
        | fields                           | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.adreshouding |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0599010000228162",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2020-04-01"
                            },
                            "bewoners": []
                        }
                    ]
                }
            ]
        }
        '''

    Scenario: geen adreshoudingen in een deel van de zoek periode
        Gegeven adresseerbaarobject met identificatie '0599010000228162' heeft de volgende adreshoudingen
        | burgerservicenummer | aanvang    | tot        |
        | 99999AAAA           | 2019-01-01 | 2020-01-01 |
        | 99999BBBB           | 2020-04-01 |            |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde                                                                                                                       |
        | adresseerbaarobjectidentificatie | 0599010000228162                                                                                                             |
        | datumVan                         | 2020-01-01                                                                                                                   |
        | datumTotEnMet                    | 2020-05-31                                                                                                                   |
        | fields                           | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.adreshouding |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0599010000228162",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2020-06-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999BBBB",
                                    "adreshouding": {
                                        "periode": {
                                            "aanvang": "2019-04-01"
                                        }
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

    Scenario: geen adreshoudingen aan het begin van de zoek periode
        Gegeven adresseerbaarobject met identificatie '0599010000228162' heeft de volgende adreshoudingen
        | burgerservicenummer | aanvang    | tot |
        | 99999BBBB           | 2020-04-01 |     |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde                                                                                                                       |
        | adresseerbaarobjectidentificatie | 0599010000228162                                                                                                             |
        | datumVan                         | 2020-01-01                                                                                                                   |
        | datumTotEnMet                    | 2020-05-31                                                                                                                   |
        | fields                           | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.adreshouding |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0599010000228162",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2020-06-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999BBBB",
                                    "adreshouding": {
                                        "periode": {
                                            "aanvang": "2019-04-01"
                                        }
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''

Rule: adreshouding is niet gekoppeld aan een adresseerbaarobject = geen bewoning voor de adreshouding

    Abstract Scenario: persoon verblijft in de gehele zoek periode op een <adres niet gekoppeld aan een adresseerbaarobject>
        Gegeven de bewoners
        | bsn       | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 99999XXXX |                                  | 2019-08-01          |                   |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde                                                                                                                       |
        | burgerservicenummer | 99999XXXX                                                                                                                    |
        | datumVan            | 2020-01-01                                                                                                                   |
        | datumTotEnMet       | 2020-12-31                                                                                                                   |
        | fields              | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.adreshouding |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": []
                        }
                    ]
                }
            ]
        }
        '''
    
        Voorbeelden:
        | adres niet gekoppeld aan een adresseerbaarobject |
        | GBA adres                                        |
        | adres in het buitenland                          |

    Abstract Scenario: persoon verblijft in een deel van de zoek periode op een <adres niet gekoppeld aan een adresseerbaarobject>
        Gegeven de bewoners
        | bsn       | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 99999XXXX | 0599010000228162                 | 2019-01-01          | 2019-08-01        |
        | 99999XXXX |                                  | 2019-08-01          | 2020-01-01        |
        | 99999XXXX | 0518010000781379                 | 2020-01-01          |                   |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde     |
        | burgerservicenummer | 99999XXXX  |
        | datumVan            | 2019-01-01 |
        | datumTotEnMet       | 2020-12-31 |
        | fields              | adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.adreshouding |
        Dan bevat de response de JSON fragment
        '''
        {
            "bewoningenhistorie": [
                {
                    "adresseerbaarObjectIdentificatie": "0599010000228162",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2019-01-01",
                                "tot": "2019-08-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX",
                                    "adreshouding": {
                                        "periode": {
                                            "aanvang": "2019-01-01",
                                            "tot": "2019-08-01"
                                        }
                                    }
                                }
                            ]
                        }
                    ]
                },
                {
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2019-08-01",
                                "tot": "2020-01-01"
                            },
                            "bewoners": []
                        }
                    ]
                },
                {
                    "adresseerbaarObjectIdentificatie": "0518010000781379",
                    "bewoningen": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": [
                                {
                                    "burgerservicenummer": "99999XXXX",
                                    "adreshouding": {
                                        "periode": {
                                            "aanvang": "2020-01-01"
                                        }
                                    }
                                }
                            ]
                        }
                    ]
                }
            ]
        }
        '''
    
        Voorbeelden:
        | adres niet gekoppeld aan een adresseerbaarobject |
        | GBA adres                                        |
        | adres in het buitenland                          |
