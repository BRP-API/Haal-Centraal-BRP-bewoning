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
    | bsn       | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
    | 99999XXXX | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
    | 99999XXXX | 0518010000781379                 | 2020-10-01          |                   |
    | 99999YYYY | 0518010000412416                 | 2020-04-01          | 2020-09-01        |
    | 99999ZZZZ | 0518010000781379                 | 2019-01-01          |                   |

Scenario: bewoning op basis van adresseerbaarObjectIdentificatie
    Als /bewoningen?adresseerbaarObjectIdentificatie=0518010000412416&van=2020-01-01&tot=2021-01-01
    Dan is de response
    '''
    {
        "bewoningen": [
            {
                "adresseerbaarObjectIdentificatie": "0518010000412416",
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-01-01",
                            "tot": "2021-01-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
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

    Als /bewoningen?adresseerbaarObjectIdentificatie=0518010000412416&van=2020-01-01&tot=2021-01-01&toonBewoonSamenstelling=true
    Dan is de response
    '''
    {
        "bewoningen": [
            {
                "adresseerbaarObjectIdentificatie": "0518010000412416",
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-01-01",
                            "tot": "2020-04-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
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
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
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
                                "bsn": "99999XXXX",
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

Scenario: bewoning op basis van bsn
    bevragen op basis van bsn komt overeen met het bevragen van bewoning voor meerdere adresseerbareobjecten, namelijk de verblijfplaaten van de persoon in de vraag periode.
    als de gevraagde persoon in de vraag periode op meerdere verblijfplaatsen heeft gewoond, dan wordt de bewoning periodes ingekort op basis van deze verblijfplaats periodes.
    in dit voorbeeld kan dat worden vertaald naar een samenvoeging van de volgende bewoning bevragingen op basis van adresseerbaarobjectidentificatie:
    - /bewoningen?adresseerbaarObjectIdentificatie=0518010000412416&van=2020-01-01&tot=2020-10-01
    - /bewoningen?adresseerbaarObjectIdentificatie=0518010000781379&van=2020-10-01&tot=2021-01-01

    Als /bewoningen?bsn=99999XXXX&van=2020-01-01&tot=2021-01-01
    Dan is de response
    '''
    {
        "bewoningen": [
            {
                "adresseerbaarObjectIdentificatie": "0518010000412416",
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-01-01",
                            "tot": "2020-10-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
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
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-10-01",
                            "tot": "2021-01-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999ZZZZ",
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

Scenario: bewoon samenstelling op basis van bsn
    Als /bewoningen?bsn=99999XXXX&van=2020-01-01&tot=2021-01-01&toonBewoonSamenstelling=true
    Dan is de response
    '''
    {
        "bewoningen": [
            {
                "adresseerbaarObjectIdentificatie": "0518010000412416",
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-01-01",
                            "tot": "2020-04-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
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
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
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
                                "bsn": "99999XXXX",
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
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-10-01",
                            "tot": "2021-01-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999ZZZZ",
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

Scenario: bewoning op peildatum
    Als /bewoningen?bsn=99999XXXX&peildatum=2020-08-31
    Dan is de response
    '''
    {
        "bewoningen": [
            {
                "adresseerbaarObjectIdentificatie": "0518010000412416",
                "adressen": [],
                "bewoningPeriodes": [
                    {
                        "periode": {
                            "van": "2020-08-31",
                            "tot": "2020-09-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999XXXX",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
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

Rule: Minimaal burgerservicenummer of adresseerbaarobjectidentificatie moet als parameter worden opgegeven

    Abstract Scenario: burgerservicenummer en adresseerbaarobjectidentificatie parameter zijn niet opgegeven
        Als /bewoningen?<query string>
        Dan bevat de response de volgende Problem JSON fragment
        '''
        {
            "title": "Geen verplichte zoek parameter opgegeven",
            "detail": "Geef minimaal burgerservicenummer of adresseerbaarobjectidentificatie als filter op"
            "status": 400,
            "instance": "/bewoningen?<query string>"
        }
        '''

        Voorbeelden:
        | query string                  |
        | peildatum=2020-08-31          |
        | van=2020-01-01&tot=2021-01-01 |

Rule: tot parameter is standaard gelijk aan de datum van morgen

    Scenario: tot parameter is niet opgegeven
        Gegeven de bewoner
        | bsn       | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 99999XXXX | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
        En morgen is 2021-11-16
        Als /bewoningen?bsn=99999XXXX&van=2020-01-01
        Dan bevat de response de volgende JSON fragment
        '''
        {
            "bewoningen": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningPeriodes": [
                        {
                            "periode": {
                                "van": "2020-01-01",
                                "tot": "2021-11-16"
                            },
                            "bewoners": [
                                {
                                    "bsn": "99999XXXX",
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

Rule: van parameter is standaard gelijk aan datum aanvang eerste adreshouding

    Scenario: Bewoning op basis van burgerservicenummer
        Gegeven de bewoner met burgerservicenummer '99999XXXX' heeft de volgende verblijfplaatsen
        | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
        | 0518010000781379                 | 2020-10-01          |                   |
        Als /bewoningen?bsn=99999XXXX&tot=2020-01-01
        Dan bevat de response de volgende JSON fragment
        '''
        {
            "bewoningen": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningPeriodes": [
                        {
                            "periode": {
                                "van": "2019-08-01",
                                "tot": "2020-01-01"
                            },
                            "bewoners": [
                                {
                                    "bsn": "99999XXXX",
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

    Scenario: burgerservicenummer: 'van' datum ligt voor datum aanvang eerste adreshouding
        Gegeven de bewoner met burgerservicenummer '99999XXXX' heeft de volgende verblijfplaatsen
        | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
        | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
        | 0518010000781379                 | 2020-10-01          |                   |
        Als /bewoningen?bsn=99999XXXX&van=2019-01-01&tot=2020-01-01
        Dan bevat de response de volgende JSON fragment
        '''
        {
            "bewoningen": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000412416",
                    "bewoningPeriodes": [
                        {
                            "periode": {
                                "van": "2019-08-01",
                                "tot": "2020-01-01"
                            },
                            "bewoners": [
                                {
                                    "bsn": "99999XXXX",
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

    Scenario: Bewoning op basis van adresseerbaarobjectidentificatie
        Gegeven de adresseerbaarobject met identificatie '0518010000781379' is verblijfplaats voor de volgende personen
        | burgerservicenummer | aanvangAdreshouding | eindeAdreshouding |
        | 99999XXXX           | 2020-10-01          |                   |
        | 99999ZZZZ           | 2019-01-01          |                   |
        Als /bewoningen?adresseerbaarobjectidentificatie=0518010000781379&tot=2021-01-01
        Dan bevat de response de volgende JSON fragment
        '''
        {
            "bewoningen": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000781379",
                    "bewoningPeriodes": [
                        {
                            "periode": {
                                "van": "2019-01-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": [
                                {
                                    "bsn": "99999XXXX",
                                    "verblijfplaats": {
                                        "adreshouding": {
                                            "aanvang": "2020-10-01"
                                        }
                                    }
                                },
                                {
                                    "bsn": "99999ZZZZ",
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

    Scenario: adresseerbaarobjectidentificatie: 'van' datum ligt voor datum aanvang eerste adreshouding
        Gegeven de adresseerbaarobject met identificatie '0518010000781379' is verblijfplaats voor de volgende personen
        | burgerservicenummer | aanvangAdreshouding | eindeAdreshouding |
        | 99999XXXX           | 2020-10-01          |                   |
        | 99999ZZZZ           | 2019-01-01          |                   |
        Als /bewoningen?adresseerbaarobjectidentificatie=0518010000781379&van2018-01-01&tot=2021-01-01
        Dan bevat de response de volgende JSON fragment
        '''
        {
            "bewoningen": [
                {
                    "adresseerbaarObjectIdentificatie": "0518010000781379",
                    "bewoningPeriodes": [
                        {
                            "periode": {
                                "van": "2019-01-01",
                                "tot": "2021-01-01"
                            },
                            "bewoners": [
                                {
                                    "bsn": "99999XXXX",
                                    "verblijfplaats": {
                                        "adreshouding": {
                                            "aanvang": "2020-10-01"
                                        }
                                    }
                                },
                                {
                                    "bsn": "99999ZZZZ",
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

    Scenario: geen bewoning op het adresseerbaarobject
    
Rule: van en/of tot parameters is niet toegestaan in combinatie met peildatum parameter

    Abstract Scenario: van en/of tot en peildatum parameters zijn opgegeven
        Als /bewoningen?burgerservicenummer=99999XXXX?<query string>
        Dan bevat de response de volgende Problem JSON fragment
        '''
        {
            "title": "Ongeldige parameters combinatie",
            "detail": "Geef of de `van en/of tot` datum(s) of `peildatum` als filter op"
            "status": 400,
            "instance": "/bewoningen?<query string>"
        }
        '''

        Voorbeelden:
        | query string                                       |
        | van=2020-01-01&tot=2021-01-01&peildatum=2020-08-31 |
        | van=2020-01-01&peildatum=2020-08-31                |
        | tot=2021-01-01&peildatum=2020-08-31                |

Rule: 'van' datum ligt voor 'tot' datum

    Abstract Scenario: waarde 'van' parameter is <vergelijking> waarde 'tot' parameter
        Als /bewoningen?burgerservicenummer=99999XXXX?van=<datum van>&tot=2020-08-01
        Dan bevat de response de volgende Problem JSON fragment
        '''
        {
            "title": "Eén of meerdere parameters zijn niet correct.",
            "detail": "`van` datum moet voor `tot` datum liggen"
            "status": 400,
            "instance": "/bewoningen?<query string>",
            "invalidParams": [
                "name": "van",
                "code": "range",
                "reason": "`van` datum moet voor `tot` datum liggen"
            ]
        }
        '''

        Voorbeelden:
        | vergelijking | datum van  |
        | gelijk aan   | 2020-08-01 |
        | groter dan   | 2020-08-02 |

Rule: 'van', 'tot' en peildatum mogen niet in de toekomst liggen
