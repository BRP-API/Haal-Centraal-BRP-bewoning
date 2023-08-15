#language: nl

Functionaliteit: Dan stap definities

  Scenario: Dan heeft de response <count> bewoningen
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": []
    }
    """
    Dan heeft de response 0 bewoningen

  Scenario: Dan heeft de response een bewoning met <count> bewoners en <count> mogelijke bewoners
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [{
        "bewoners": [
          "1",
          "2"
        ],
        "mogelijkeBewoners": [
          "3",
          "4",
          "5"
        ]
      }]
    }
    """
    Dan heeft de response een bewoning met 2 bewoners en 3 mogelijke bewoners

  Scenario: Dan heeft de response een bewoning met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0518010000713450",
          "periode": {
            "datumVan": "2012-01-01",
            "datumTot": "2013-01-01"
          },
          "bewoners": [],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |

  Scenario: Dan heeft de bewoning geen bewoners en geen mogelijke bewoners
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0518010000713450",
          "periode": {
            "datumVan": "2012-01-01",
            "datumTot": "2013-01-01"
          },
          "bewoners": [],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning geen bewoners en geen mogelijke bewoners

  Scenario: Dan heeft de bewoning een bewoner met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0518010000713450",
          "periode": {
            "datumVan": "2012-01-01",
            "datumTot": "2013-01-01"
          },
          "bewoners": [
            {
              "burgerservicenummer": "000000024"
            }
          ],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Dan heeft de bewoning bewoners met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0518010000713450",
          "periode": {
            "datumVan": "2012-01-01",
            "datumTot": "2013-01-01"
          },
          "bewoners": [
            {
              "burgerservicenummer": "000000024"
            },
            {
              "burgerservicenummer": "000000048"
            }
          ],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

  Scenario: Dan heeft de bewoning een mogelijke bewoner met de volgende gegevens
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0518010000713450",
          "periode": {
            "datumVan": "2012-01-01",
            "datumTot": "2013-01-01"
          },
          "bewoners": [],
          "mogelijkeBewoners": [
            {
              "burgerservicenummer": "000000024"
            }
          ]
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: En heeft de bewoner de volgende <gegevensgroep> gegevens
      Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": [
        {
          "adresseerbaarObjectIdentificatie": "0518010000713450",
          "periode": {
            "datumVan": "2012-01-01",
            "datumTot": "2013-01-01"
          },
          "bewoners": [
            {
              "burgerservicenummer": "000000024",
              "verblijfplaatsInOnderzoek": {
                "aanduidingGegevensInOnderzoek": "080000",
                "datumIngangOnderzoek" : "20200401"
              }
            }
          ],
          "mogelijkeBewoners": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de bewoner de volgende 'verblijfplaatsInOnderzoek' gegevens
    | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | 080000                        | 20200401             |
