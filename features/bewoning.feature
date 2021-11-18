# language: nl

Functionaliteit: Bewoning

    Als medewerker
    Wil ik bevragen welke personen op een verblijfplaats wonen/hebben gewoond

    Als medewerker
    Wil ik bevragen welke personen op de verblijfplaatsen van een persoon wonen/hebben gewoond

    Als medewerker
    Wil ik bevragen welke personen op hetzelfde moment op een verblijfplaats hebben gewoond

Achtergrond:
    Gegeven de bewoners
    | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
    | 99999XXXX           | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
    | 99999XXXX           | 0518010000781379                 | 2020-10-01          |                   |
    | 99999YYYY           | 0518010000412416                 | 2020-04-01          | 2020-09-01        |
    | 99999ZZZZ           | 0518010000781379                 | 2019-01-01          |                   |
    En de fields parameter met waarde 'adresseerbaarObjectIdentificatie,bewoningen.periode,bewoningen.bewoners.burgerservicenummer,bewoningen.bewoners.verblijfplaats'

Scenario: bewoning op basis van adresseerbaarObjectIdentificatie
    Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000412416 |
    | datumVan                         | 2020-01-01       |
    | datumTotEnMet                    | 2020-12-31       |
    Dan is de response
    '''
    {
        "bewoningenhistorie": [
            {
                "adresseerbaarObjectIdentificatie": "0518010000412416",
                "bewoningen": [
                    {
                        "periode": {
                            "van": "2020-01-01",
                            "tot": "2021-01-01"
                        },
                        "bewoners": [
                            {
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "burgerservicenummer": "99999YYYY",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-04-01",
                                        "tot": "2020-09-01"
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

Scenario: bewoon samenstelling op basis van adresseerbaarObjectIdentificatie
    bewoning periodes wordt gesplitst door verandering in bewoon samenstelling

    Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000412416 |
    | datumVan                         | 2020-01-01       |
    | datumTotEnMet                    | 2020-12-31       |
    | toonBewoonSamenstelling          | true             |
    Dan is de response
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "burgerservicenummer": "99999YYYY",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-04-01",
                                        "tot": "2020-09-01"
                                    }
                                }
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
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

Scenario: bewoning op basis van burgerservicenummer
    bevragen op basis van burgerservicenummer komt overeen met het bevragen van bewoning voor meerdere adresseerbareobjecten, namelijk de verblijfplaaten van de persoon in de vraag periode.
    als de gevraagde persoon in de vraag periode op meerdere verblijfplaatsen heeft gewoond, dan wordt de bewoning periodes ingekort op basis van deze verblijfplaats periodes.
    in dit voorbeeld kan dat worden vertaald naar een samenvoeging van de volgende bewoning bevragingen op basis van adresseerbaarobjectidentificatie:
    - /bewoningen?adresseerbaarObjectIdentificatie=0518010000412416&van=2020-01-01&tot=2020-10-01
    - /bewoningen?adresseerbaarObjectIdentificatie=0518010000781379&van=2020-10-01&tot=2021-01-01

    Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
    | naam                | waarde     |
    | burgerservicenummer | 99999XXXX  |
    | datumVan            | 2020-01-01 |
    | datumTotEnMet       | 2020-12-31 |
    Dan is de response
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "burgerservicenummer": "99999YYYY",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-04-01",
                                        "tot": "2020-09-01"
                                    }
                                }
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "burgerservicenummer": "99999ZZZZ",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-01-01"
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

Scenario: bewoon samenstelling op basis van burgerservicenummer
    Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
    | naam                    | waarde     |
    | burgerservicenummer     | 99999XXXX  |
    | datumVan                | 2020-01-01 |
    | datumTotEnMet           | 2020-12-31 |
    | toonBewoonSamenstelling | true       |
    Dan is de response
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "burgerservicenummer": "99999YYYY",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-04-01",
                                        "tot": "2020-09-01"
                                    }
                                }
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
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
                                "burgerservicenummer": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "burgerservicenummer": "99999ZZZZ",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-01-01"
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

Rule: peildatum komt overeen met datumVan en datumTotEnMet met dezelfde datum

    Scenario: zoek op peildatum
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde     |
        | burgerservicenummer | 99999XXXX  |
        | peildatum           | 2020-08-31 |
        Dan is de response
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
                                    "burgerservicenummer": "99999XXXX",
                                    "verblijfplaats": {
                                        "adreshouding": {
                                            "aanvang": "2019-08-01",
                                            "tot": "2020-10-01"
                                        }
                                    }
                                },
                                {
                                    "burgerservicenummer": "99999YYYY",
                                    "verblijfplaats": {
                                        "adreshouding": {
                                            "aanvang": "2020-04-01",
                                            "tot": "2020-09-01"
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

Rule: datumVan en datumTotEnMet zijn standaard gelijk aan de datum van vandaag
    Voor scenario 'datumVan is niet opgegeven en datumTotEnMet is opgegeven', zie bewoninghistorie-parameters-validatie.feature

    Scenario: datumVan is opgegeven en datumTotEnMet is niet opgegeven
        Gegeven de bewoner
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 99999XXXX           | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
        En datum vandaag is 2021-11-15
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde     |
        | burgerservicenummer | 99999XXXX  |
        | datumVan            | 2020-01-01 |
        Dan bevat de response de volgende JSON fragment
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
                                    "burgerservicenummer": "99999XXXX",
                                    "verblijfplaats": {
                                        "adreshouding": {
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

    Scenario: datumVan en datumTotEnMet zijn niet opgegeven
        Gegeven de bewoner
        | burgerservicenummer | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 99999ZZZZ           | 0518010000781379                 | 2019-01-01          |                   |
        En datum vandaag is 2021-11-15
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                | waarde    |
        | burgerservicenummer | 99999ZZZZ |
        Dan bevat de response de volgende JSON fragment
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
                                    "burgerservicenummer": "99999ZZZZ",
                                    "verblijfplaats": {
                                        "adreshouding": {
                                            "aanvang": "2019-01-01"
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

Rule: geen adreshouding in een periode = geen bewoners in de periode

    Scenario: geen adreshoudingen in de gehele zoek periode
        Gegeven adresseerbaarobject met identificatie '0599010000228162' heeft de volgende adreshoudingen
        | burgerservicenummer | aanvang    | tot        |
        | 99999AAAA           | 2019-01-01 | 2020-01-01 |
        | 99999BBBB           | 2020-04-01 |            |
        Als de endpoint '/bewoningenhistorie' met de volgende parameters wordt aangeroepen
        | naam                             | waarde           |
        | adresseerbaarobjectidentificatie | 0599010000228162 |
        | datumVan                         | 2020-01-01       |
        | datumTotEnMet                    | 2020-03-31       |
        Dan bevat de response de volgende JSON fragment
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
        | naam                             | waarde           |
        | adresseerbaarobjectidentificatie | 0599010000228162 |
        | datumVan                         | 2020-01-01       |
        | datumTotEnMet                    | 2020-05-31       |
        Dan bevat de response de volgende JSON fragment
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
                                    "verblijfplaats": {
                                        "adreshouding": {
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
        | naam                             | waarde           |
        | adresseerbaarobjectidentificatie | 0599010000228162 |
        | datumVan                         | 2020-01-01       |
        | datumTotEnMet                    | 2020-05-31       |
        Dan bevat de response de volgende JSON fragment
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
                                    "verblijfplaats": {
                                        "adreshouding": {
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
        | naam                | waarde     |
        | burgerservicenummer | 99999XXXX  |
        | datumVan            | 2020-01-01 |
        | datumTotEnMet       | 2020-12-31 |
        Dan is de response
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
        Dan is de response
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
                                    "verblijfplaats": {
                                        "adreshouding": {
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
                                    "verblijfplaats": {
                                        "adreshouding": {
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
