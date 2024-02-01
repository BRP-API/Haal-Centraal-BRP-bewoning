#language: nl

@gba
Functionaliteit: raadpleeg bewoning in periode - fout cases

Rule: De adresseerbaarObjectIdentificatie, datumVan en datumTot parameters zijn verplichte parameters

  @fout-case
  Scenario: De adresseerbaarObjectIdentificatie, datumVan en datumTot parameters zijn niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam | waarde             |
    | type | BewoningMetPeriode |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                               |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                          |
    | title    | Een of meerdere parameters zijn niet correct.                                        |
    | status   | 400                                                                                  |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie, datumTot, datumVan. |
    | code     | paramsValidation                                                                     |
    | instance | /haalcentraal/api/bewoning/bewoningen                                                |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                             | reason                  |
    | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |
    | required | datumVan                         | Parameter is verplicht. |
    | required | datumTot                         | Parameter is verplicht. |

  @fout-case
  Scenario: De adresseerbaarObjectIdentificatie parameter is niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam     | waarde             |
    | type     | BewoningMetPeriode |
    | datumVan | 2022-01-01         |
    | datumTot | 2023-01-01         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                           |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
    | title    | Een of meerdere parameters zijn niet correct.                    |
    | status   | 400                                                              |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
    | code     | paramsValidation                                                 |
    | instance | /haalcentraal/api/bewoning/bewoningen                            |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                             | reason                  |
    | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |

  @fout-case
  Scenario: De datumTot parameter is niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | datumVan                         | 2022-01-01         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumTot.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name     | reason                  |
    | required | datumTot | Parameter is verplicht. |

  @fout-case
  Scenario: De datumVan parameter is niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | datumTot                         | 2023-01-01         |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumVan.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name     | reason                  |
    | required | datumVan | Parameter is verplicht. |

  @fout-case
  Scenario: een lege string is opgegeven als adresseerbaarObjectIdentificatie waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie |                    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                           |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
    | title    | Een of meerdere parameters zijn niet correct.                    |
    | status   | 400                                                              |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
    | code     | paramsValidation                                                 |
    | instance | /haalcentraal/api/bewoning/bewoningen                            |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                             | reason                  |
    | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |

  @fout-case
  Scenario: een lege string is opgegeven als datumTot waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         |                    |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumTot.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name     | reason                  |
    | required | datumTot | Parameter is verplicht. |

  @fout-case
  Scenario: een lege string is opgegeven als datumVan waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         |                    |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumVan.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name     | reason                  |
    | required | datumVan | Parameter is verplicht. |

Rule: Een valide adresseerbaarObjectIdentificatie is een string bestaande uit exact 16 cijfers, 16 nullen niet inbegrepen

  @fout-case
  Abstract Scenario: <omschrijving>
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                             |
    | type                             | BewoningMetPeriode                 |
    | datumVan                         | 2022-01-01                         |
    | datumTot                         | 2023-01-01                         |
    | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie> |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                           |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
    | title    | Een of meerdere parameters zijn niet correct.                    |
    | status   | 400                                                              |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
    | code     | paramsValidation                                                 |
    | instance | /haalcentraal/api/bewoning/bewoningen                            |
    En heeft het object de volgende 'invalidParams' gegevens
    | code    | name                             | reason                                                |
    | pattern | adresseerbaarObjectIdentificatie | Waarde voldoet niet aan patroon ^(?!0{16})[0-9]{16}$. |

    Voorbeelden:
    | adresseerbaarObjectIdentificatie  | omschrijving                                                                          |
    | 123456789012345                   | de opgegeven adresseerbaarObjectIdentificatie is een string met minder dan 16 cijfers |
    | 12345678901234567                 | de opgegeven adresseerbaarObjectIdentificatie is een string met meer dan 16 cijfers   |
    | <script>1234567890123456</script> | de opgegeven adresseerbaarObjectIdentificatie bevat niet-cijfer karakters             |
    | 0000000000000000                  | de opgegeven adresseerbaarObjectIdentificatie is een string bestaande uit 16 nullen   |

Rule: datumVan en datumTot zijn een datum string geformatteerd volgens de [ISO 8601 date format](https://www.w3.org/QA/Tips/iso-date)

  @fout-case
  Abstract Scenario: een ongeldig datum is opgegeven als datumTot waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumTot.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code | name     | reason                        |
    | date | datumTot | Waarde is geen geldige datum. |

    Voorbeelden:
    | datum tot   |
    | 19830526    |
    | 26 mei 1983 |
    | 2023-02-29  |

  @fout-case
  Abstract Scenario: een ongeldig datum is opgegeven als datumVan waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumVan.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code | name     | reason                        |
    | date | datumVan | Waarde is geen geldige datum. |

    Voorbeelden:
    | datum van   |
    | 19830526    |
    | 26 mei 1983 |
    | 2023-02-29  |

Rule: datumTot ligt na datumVan

  @fout-case
  Abstract Scenario: datumTot ligt op/vóór datumVan
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2023-01-01         |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: datumTot.                    |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code | name     | reason                            |
    | date | datumTot | datumTot moet na datumVan liggen. |

    Voorbeelden:
    | datum tot  |
    | 2023-01-01 |
    | 2022-01-01 |

Rule: Alleen gespecificeerde parameters bij het opgegeven raadpleeg type mogen worden gebruikt

  @fout-case
  Abstract Scenario: <omschrijving>
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2023-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | <parameter>                      | <waarde>           |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code         | name        | reason                      |
    | unknownParam | <parameter> | Parameter is niet verwacht. |

    Voorbeelden:
    | omschrijving                                      | parameter     | waarde     |
    | raadplegen met parameter uit ander raadpleeg type | peildatum     | 2022-01-01 |
    | raadplegen met niet gespecificeerde parameter     | geheimhouding | false      |
