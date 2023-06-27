#language: nl

Functionaliteit: Fout cases bij raadplegen van bewoningen

Rule: Er moet een valide raadpleeg type worden opgegeven

  @fout-case
  Scenario: er zijn geen parameters opgegeven
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
  Scenario: de 'type' parameter is niet opgegeven
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
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
  Abstract Scenario: een <omschrijving> is opgegeven als 'type' waarde
    Als bewoning wordt gezocht met de volgende parameters
    | naam | waarde      |
    | type | <zoek type> |
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
    | omschrijving                          | zoek type                  |
    | lege string                           |                            |
    | onbekend zoek type                    | BewoningMetGeslachtsnaam   |
    | geldig zoek type met verkeerde casing | bewoningmetpeildatum       |

Rule: De ondersteunde content type en charset voor de response body zijn respectievelijk application/json en utf-8

  @fout-case
  Scenario: 'application/xml' is opgegeven als Accept content type
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | header: Accept                   | application/xml      |
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.6 |
    | title    | Gevraagde content type wordt niet ondersteund.              |
    | detail   | Ondersteunde content type: application/json; charset=utf-8. |
    | code     | notAcceptable                                               |
    | status   | 406                                                         |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |

  Abstract Scenario: '<accept media type>' wordt opgegeven als Accept content type
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | header: Accept                   | <accept media type>  |
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

Rule: De default content type en charset voor de response body zijn respectievelijk application/json en utf-8

  Scenario: er is geen Accept header opgegeven
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response 0 bewoningen

  Scenario: er is een Accept header met lege waarde opgegeven
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | header: Accept                   |                      |
    Dan heeft de response 0 bewoningen

Rule: De ondersteunde content type en charset voor de request body zijn respectievelijk application/json en utf-8

  @fout-case
  Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | header: Content-Type             | <media type>         |
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

  Abstract Scenario: '<media type>' is opgegeven als Content-Type waarde
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | header: Content-Type             | <media type>         |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | media type                      |
    | application/json                |
    | application/json;charset=utf-8  |
    | application/json; charset=utf-8 |
    | application/json;charset=Utf-8  |
    | application/json; charset=UTF-8 |

Rule: De default content type en charset voor de request body zijn respectievelijk application/json en utf-8

  Scenario: er is geen Content-Type header opgegeven
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response 0 bewoningen

  Scenario: er is een Content-Type header met lege waarde opgegeven
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | gisteren             |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    | header: Content-Type             |                      |
    Dan heeft de response 0 bewoningen

Rule: Om privacy en security redenen moet een bevraging van bewoningen worden gedaan met behulp van de POST aanroep

  @fout-case
  Abstract Scenario: bewoningen wordt gezocht met een '<aanroep type>' aanroep
    Als bewoning wordt gezocht met een '<aanroep type>' aanroep
    Dan heeft de response een object met de volgende gegevens
    | naam     | waarde                                                      |
    | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.5 |
    | title    | Method not allowed.                                         |
    | status   | 405                                                         |
    | instance | /haalcentraal/api/bewoning/bewoningen                       |

    Voorbeelden:
    | aanroep type |
    | GET          |
    | PUT          |
    | PATCH        |
    | DELETE       |
  # | CONNECT      | een CONNECT aanroep wordt niet gebruikt om te bevragen
  # | HEAD         | een HEAD response bevat geen body
    | OPTIONS      |
    | TRACE        |
