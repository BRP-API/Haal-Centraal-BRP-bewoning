#language: nl

@gba
Functionaliteit: Raadpleeg bewoning op peildatum - fout cases

Rule: De adresseerbaarObjectIdentificatie en peildatum parameters zijn verplichte parameters

  @fout-case
  Scenario: De adresseerbaarObjectIdentificatie en peildatum parameters zijn niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam | waarde               |
    | type | BewoningMetPeildatum |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1                 |
    | title    | Een of meerdere parameters zijn niet correct.                               |
    | status   | 400                                                                         |
    | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie, peildatum. |
    | code     | paramsValidation                                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name                             | reason                  |
    | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |
    | required | peildatum                        | Parameter is verplicht. |

  @fout-case
  Scenario: De adresseerbaarObjectIdentificatie parameter is niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam      | waarde               |
    | type      | BewoningMetPeildatum |
    | peildatum | 2023-01-01           |
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
  Scenario: De peildatum parameter is niet opgegeven
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: peildatum.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name      | reason                  |
    | required | peildatum | Parameter is verplicht. |

  @fout-case
  Scenario: een lege string is opgegeven als adresseerbaarObjectIdentificatie waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie |                      |
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
  Scenario: een lege string is opgegeven als peildatum waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        |                      |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: peildatum.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name      | reason                  |
    | required | peildatum | Parameter is verplicht. |

Rule: Een valide adresseerbaarObjectIdentificatie is een string bestaande uit exact 16 cijfers, 16 nullen niet inbegrepen

  @fout-case
  Abstract Scenario: <omschrijving>
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                             |
    | type                             | BewoningMetPeildatum               |
    | peildatum                        | 2023-01-01                         |
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

Rule: De peildatum is een datum string geformatteerd volgens de [ISO 8601 date format](https://www.w3.org/QA/Tips/iso-date)

  @fout-case
  Abstract Scenario: een ongeldig datum is opgegeven als peildatum waarde
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: peildatum.                   |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code | name      | reason                        |
    | date | peildatum | Waarde is geen geldige datum. |

    Voorbeelden:
    | peildatum   |
    | 19830526    |
    | 26 mei 1983 |
    | 2023-02-29  |

Rule: Alleen gespecificeerde parameters bij het opgegeven raadpleeg type mogen worden gebruikt

  @fout-case
  Abstract Scenario: <omschrijving>
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | <parameter>                      | <waarde>             |
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
    | omschrijving                                      | parameter                        | waarde                    |
    | raadplegen met parameter uit ander raadpleeg type | periode                          | 2022-01-01 tot 2023-01-01 |
    | raadplegen met niet gespecificeerde parameter     | geheimhouding                    | false                     |
