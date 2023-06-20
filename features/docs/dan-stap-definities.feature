#language: nl

Functionaliteit: Dan stap definities

  Scenario: Dan heeft de response geen bewoningen
    Gegeven de response body is gelijk aan
    """
    {
      "bewoningen": []
    }
    """
    Dan heeft de response geen bewoningen

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
          "bewoningPeriodes": []
        }
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |

  Scenario: Dan heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners
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
          "bewoningPeriodes": [
            {
              "periode": {
                "datumVan": "2012-01-01",
                "datumTot": "2013-01-01"
              },
              "bewoners": [],
              "mogelijkeBewoners": []
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
    En heeft de bewoning voor de bewoningPeriode '2012-01-01 tot 2013-01-01' geen bewoners

  Scenario: Dan heeft de bewoning voor de bewoningPeriode '<periode>' een bewoner met de volgende gegevens
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
          "bewoningPeriodes": [
            {
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
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2012-01-01 tot 2013-01-01' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Dan heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
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
          "bewoningPeriodes": [
            {
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
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2012-01-01 tot 2013-01-01' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

  Scenario: Dan heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
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
          "bewoningPeriodes": [
            {
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
      ]
    }
    """
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2013-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2012-01-01 tot 2013-01-01' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Dan heeft de bewoning voor de bewoningPeriode '<periode>' mogelijke bewoners met de volgende gegevens
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
          "bewoningPeriodes": [
            {
              "periode": {
                "datumVan": "2012-01-01",
                "datumTot": "2013-01-01"
              },
              "bewoners": [],
              "mogelijkeBewoners": [
                {
                  "burgerservicenummer": "000000024"
                },
                {
                  "burgerservicenummer": "000000048"
                }
              ]
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
    En heeft de bewoning voor de bewoningPeriode '2012-01-01 tot 2013-01-01' mogelijke bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |
