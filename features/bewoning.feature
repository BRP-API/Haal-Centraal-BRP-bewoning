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
                                    "periode": {
                                        "van": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2020-04-01",
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
                                    "periode": {
                                        "van": "2019-08-01",
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
                                    "periode": {
                                        "van": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2020-04-01",
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
                                    "periode": {
                                        "van": "2019-08-01",
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
                                    "periode": {
                                        "van": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2020-04-01",
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
                                    "periode": {
                                        "van": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999ZZZZ",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2019-01-01"
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
    Als /bewoningen?bsn=99999XXXX&van=2020-01-01&tot=2021-01-01&bewoonSamenstelling=true
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
                                    "periode": {
                                        "van": "2019-08-01",
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
                                    "periode": {
                                        "van": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2020-04-01",
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
                                    "periode": {
                                        "van": "2019-08-01",
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
                                    "periode": {
                                        "van": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999ZZZZ",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2019-01-01"
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
                                    "periode": {
                                        "van": "2019-08-01",
                                        "tot": "2020-10-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999YYYY",
                                "verblijfplaats": {
                                    "periode": {
                                        "van": "2020-04-01",
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
