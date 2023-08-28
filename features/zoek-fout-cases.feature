#language: nl

Functionaliteit: Zoeken

Rule: Er moet een valide zoek type worden opgegeven

  @fout-case
  Scenario: zoek zonder opgeven van parameters
    Als bewoning wordt gezocht met de volgende parameters
    | naam | waarde |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek zonder opgeven van 'type' parameter
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde           |
    | datumVan                         | 2014-01-01       |
    | datumTot                         | 2016-05-01       |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code     | name | reason                  |
    | required | type | Parameter is verplicht. |

  @fout-case
  Scenario: zoek met lege type 
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde           |
    | type                             |                  |
    | datumVan                         | 2014-01-01       |
    | datumTot                         | 2016-05-01       |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

  @fout-case
  Abstract Scenario: zoek met ongeldige type waarde
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde           |
    | type                             | <type>           |
    | datumVan                         | 2014-01-01       |
    | datumTot                         | 2016-05-01       |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
    | title    | Een of meerdere parameters zijn niet correct.               |
    | status   | 400                                                         |
    | detail   | De foutieve parameter(s) zijn: type.                        |
    | code     | paramsValidation                                            |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |
    En heeft het object de volgende 'invalidParams' gegevens
    | code  | name | reason                           |
    | value | type | Waarde is geen geldig zoek type. |

    Voorbeelden:
    | omschrijving               | type               |
    | ongeldig zoek type         | OnbekendZoekType   |
    | type voldoet niet aan case | bewoningmetperiode |


Rule: als content type voor de response wordt alleen application/json en charset utf-8 ondersteund

  @fout-case
  Scenario: Gevraagde Accept content type wordt niet ondersteund
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2016-05-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | header: Accept                   | application/xml    |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
    | title    | Gevraagde content type wordt niet ondersteund.              |
    | detail   | Ondersteunde content type: application/json; charset=utf-8. |
    | code     | notAcceptable                                               |
    | status   | 406                                                         |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |

  Abstract Scenario: '<accept media type>' als Accept content type wordt ondersteund
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde              |
    | type                             | BewoningMetPeriode  |
    | datumVan                         | 2014-01-01          |
    | datumTot                         | 2016-05-01          |
    | adresseerbaarObjectIdentificatie | 0800010000000001    |
    | header: Accept                   | <accept media type> |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | accept media type               |
    | */*                             |
    | */*; charset=utf-8              |
    | */*;charset=utf-8               |
    | application/json                |
    | application/json; charset=utf-8 |
    | application/json;charset=utf-8  |
    | */*;charset=UTF-8               |
    | application/json;charset=Utf-8  |
    | application/json; charset=UTF-8 |


Rule: als content type voor het request wordt alleen application/json en charset utf-8 ondersteund

  Abstract Scenario: '<media type>' als Content-Type waarde wordt ondersteund
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2016-05-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | header: Content-Type             | <media type>       |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | media type                      |
    | application/json                |
    | application/json;charset=utf-8  |
    | application/json; charset=utf-8 |
    | application/json;charset=Utf-8  |
    | application/json; charset=UTF-8 |

  @fout-case
  Abstract Scenario: '<media type>' als Content-Type waarde wordt niet ondersteund
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2016-05-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | header: Content-Type             | <media type>       |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                       |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.13 |
    | title    | Media Type wordt niet ondersteund.                           |
    | detail   | Ondersteunde content type: application/json; charset=utf-8.  |
    | code     | unsupportedMediaType                                         |
    | status   | 415                                                          |
    | instance | /haalcentraal/api/bewoning/bewoningen                        |

    Voorbeelden:
    | media type                       |
    | application/xml                  |
    | text/csv                         |
    | application/json; charset=cp1252 |
    | */*                              |
    | */*; charset=utf-8               |
    | */*;charset=utf-8                |


Rule: content type voor de response is default application/json en charset utf-8

  Scenario: Lege Accept content type wordt ondersteund
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2016-05-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | header: Accept                   |                    |
    Dan heeft de response 0 bewoningen


Rule: content type voor het request is default application/json en charset utf-8

  Scenario: Lege Content-Type wordt ondersteund
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2016-05-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    | header: Content-Type             |                    |
    Dan heeft de response 0 bewoningen
