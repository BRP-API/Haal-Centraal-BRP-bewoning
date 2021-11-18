# language: nl

Functionaliteit: Bewoning randgevallen

Scenario: persoon verblijft in het buitenland in de gevraagde periode
    Gegeven de bewoners
    | bsn       | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
    | 99999XXXX | 0518010000412416                 | 2019-08-01          | 2020-10-01        |
    Als /bewoningen?bsn=99999XXXX&van=2019-01-01&tot=2019-08-01
    Dan is de response
    '''
    {
        "bewoningen": [
        ]
    }
    '''

Scenario: persoon verbleef een gedeelte van de gevraagde periode in het buitenland
    aanname: verblijf in buitenland is in BRP geregistreerd als een verblijfplaats zonder adresseerbaarObjectIdentificatie 
    Gegeven de bewoner met bsn 99999AAAA met de volgende verblijfplaatsen
    | adresseerbaarObjectIdentificatie | aanvangAdreshouding | eindeAdreshouding |
    | 0518010000412416                 | 2020-01-01          | 2020-08-01        |
    |                                  | 2020-08-01          | 2020-12-01        |
    | 0518010000412416                 | 2020-12-01          |                   |
    Als /bewoningen?bsn=99999AAAA&van=2020-01-01&tot=2021-01-01
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
                                "bsn": "99999AAAA",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-01-01",
                                        "tot": "2020-08-01"
                                    }
                                }
                            },
                            {
                                "bsn": "99999AAAA",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-12-01"
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

    Als /bewoningen?bsn=99999AAAA&van=2020-01-01&tot=2021-01-01&toonBewoonSamenstelling=true
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
                            "tot": "2020-08-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999AAAA",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-01-01",
                                        "tot": "2020-08-01"
                                    }
                                }
                            }
                        ]
                    },
                    {
                        "periode": {
                            "van": "2020-12-01",
                            "tot": "2021-01-01"
                        },
                        "bewoners": [
                            {
                                "bsn": "99999AAAA",
                                "verblijfplaats": {
                                    "adreshouding": {
                                        "aanvang": "2020-12-01"
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
