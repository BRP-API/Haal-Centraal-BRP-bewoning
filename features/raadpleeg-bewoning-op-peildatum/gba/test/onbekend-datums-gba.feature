#language: nl

@gba
Functionaliteit: bewoning op peildatum met geheel of gedeeltelijk onbekende datums

    Achtergrond:
      Gegeven adres 'vorige' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'gevraagd' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |
      En adres 'volgende' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En adres 'daaropvolgende' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000004                         |

  Rule: een persoon is mogelijke bewoner tijdens de onzekerheidsperiode van de datum aanvang en bewoner na de onzekerheidsperiode

    Abstract Scenario: eerste en enige verblijfplaats met gedeeltelijk onbekende datum aanvang en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                       | datum aanvang | peildatum  | periode tot |
      | peildatum is eerste dag onzekerheidsperiode maand  | 20210500      | 2021-05-01 | 2021-05-02  |
      | peildatum in onzekerheidsperiode maand             | 20210500      | 2021-05-15 | 2021-05-16  |
      | peildatum is laatste dag onzekerheidsperiode maand | 20210500      | 2021-05-31 | 2021-06-01  |
      | peildatum is eerste dag onzekerheidsperiode jaar   | 20210000      | 2021-01-01 | 2021-01-02  |
      | peildatum in onzekerheidsperiode jaar              | 20210000      | 2021-05-15 | 2021-05-16  |
      | peildatum is laatste dag onzekerheidsperiode jaar  | 20210000      | 2021-12-31 | 2022-01-01  |

    Abstract Scenario: eerste en enige verblijfplaats met gedeeltelijk onbekende datum aanvang en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                         | datum aanvang | peildatum  | periode tot |
      | peildatum is eerste dag na onzekerheidsperiode maand | 20210500      | 2021-06-01 | 2021-06-02  |
      | peildatum ligt na onzekerheidsperiode maand          | 20210500      | 2021-10-31 | 2021-11-01  |
      | peildatum is eerste dag na onzekerheidsperiode jaar  | 20210000      | 2022-01-01 | 2022-01-02  |
      | peildatum ligt na onzekerheidsperiode jaar           | 20210000      | 2022-07-09 | 2022-07-10  |

    Abstract Scenario: eerste en enige verblijfplaats met gedeeltelijk onbekende datum aanvang en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                    | datum aanvang | peildatum  |
      | peildatum is dag voor onzekerheidsperiode maand | 20210500      | 2021-04-30 |
      | peildatum ligt voor onzekerheidsperiode maand   | 20210500      | 2020-07-30 |
      | peildatum is dag voor onzekerheidsperiode jaar  | 20210000      | 2020-12-31 |
      | peildatum ligt voor onzekerheidsperiode jaar    | 20210000      | 2020-07-30 |

    Abstract Scenario: eerste en enige verblijfplaats met gedeeltelijk onbekende datum aanvang, er is een andere bewoner en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | omschrijving                                    | datum aanvang | peildatum  | periode tot |
      | peildatum is dag voor onzekerheidsperiode maand | 20210500      | 2021-04-30 | 2021-05-01  |
      | peildatum ligt voor onzekerheidsperiode maand   | 20210500      | 2020-07-30 | 2020-07-31  |
      | peildatum is dag voor onzekerheidsperiode jaar  | 20210000      | 2020-12-31 | 2021-01-01  |
      | peildatum ligt voor onzekerheidsperiode jaar    | 20210000      | 2020-07-30 | 2020-07-31  |

    Abstract Scenario: eerste en enige verblijfplaats met volledig onbekende datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | peildatum  | periode tot |
      | 1953-02-01 | 1953-02-02  |
      | 2020-01-01 | 2020-01-02  |
      | 2023-10-31 | 2023-11-01  |

    Abstract Scenario: volgende verblijfplaats na onzekerheidsperiode en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                       | datum aanvang | peildatum  | periode tot |
      | peildatum is eerste dag onzekerheidsperiode maand  | 20210500      | 2021-05-01 | 2021-05-02  |
      | peildatum in onzekerheidsperiode maand             | 20210500      | 2021-05-15 | 2021-05-16  |
      | peildatum is laatste dag onzekerheidsperiode maand | 20210500      | 2021-05-31 | 2021-06-01  |
      | peildatum is eerste dag onzekerheidsperiode jaar   | 20210000      | 2021-01-01 | 2021-01-02  |
      | peildatum in onzekerheidsperiode jaar              | 20210000      | 2021-05-15 | 2021-05-16  |
      | peildatum is laatste dag onzekerheidsperiode jaar  | 20210000      | 2021-12-31 | 2022-01-01  |

    Abstract Scenario: volgende verblijfplaats na onzekerheidsperiode en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                         | datum aanvang | peildatum  | periode tot |
      | peildatum is eerste dag na onzekerheidsperiode maand | 20210500      | 2021-06-01 | 2021-06-02  |
      | peildatum ligt na onzekerheidsperiode maand          | 20210500      | 2021-10-31 | 2021-11-01  |
      | peildatum is eerste dag na onzekerheidsperiode jaar  | 20210000      | 2022-01-01 | 2022-01-02  |
      | peildatum ligt na onzekerheidsperiode jaar           | 20210000      | 2022-07-09 | 2022-07-10  |
      | peildatum is dag voor aanvang volgende               | 20210000      | 2022-10-13 | 2022-10-14  |

    Abstract Scenario: volgende verblijfplaats na onzekerheidsperiode en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                    | datum aanvang | peildatum  |
      | peildatum is dag voor onzekerheidsperiode maand | 20210500      | 2021-04-30 |
      | peildatum ligt voor onzekerheidsperiode maand   | 20210500      | 2020-07-30 |
      | peildatum is dag voor onzekerheidsperiode jaar  | 20210000      | 2020-12-31 |
      | peildatum ligt voor onzekerheidsperiode jaar    | 20210000      | 2020-07-30 |
      | peildatum is datum aanvang volgende             | 20210000      | 2022-10-14 |
      | peildatum na datum aanvang volgende             | 20210000      | 2022-11-03 |

    Abstract Scenario: volgende verblijfplaats na onzekerheidsperiode, er is een andere bewoner en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | omschrijving                                    | datum aanvang | peildatum  | periode tot |
      | peildatum is dag voor onzekerheidsperiode maand | 20210500      | 2021-04-30 | 2021-05-01  |
      | peildatum ligt voor onzekerheidsperiode maand   | 20210500      | 2020-07-30 | 2020-07-31  |
      | peildatum is dag voor onzekerheidsperiode jaar  | 20210000      | 2020-12-31 | 2021-01-01  |
      | peildatum ligt voor onzekerheidsperiode jaar    | 20210000      | 2020-07-30 | 2020-07-31  |
      | peildatum is datum aanvang volgende             | 20210000      | 2022-10-14 | 2022-10-15  |
      | peildatum na datum aanvang volgende             | 20210000      | 2022-11-03 | 2022-11-04  |

    Abstract Scenario: volgende verblijfplaats in onzekerheidsperiode en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                              | datum aanvang | peildatum  | periode tot |
      | peildatum is eerste dag onzekerheidsperiode maand                     | 20210500      | 2021-05-01 | 2021-05-02  |
      | peildatum is eerste dag onzekerheidsperiode jaar                      | 20210000      | 2021-01-01 | 2021-01-02  |
      | peildatum is dag voor aanvang volgende                                | 20210000      | 2021-05-25 | 2021-05-26  |
      | datum aanvang is volledig onbekend en peildatum voor aanvang volgende | 00000000      | 2020-01-01 | 2020-01-02  |

    Abstract Scenario: volgende verblijfplaats in onzekerheidsperiode en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                                  | datum aanvang | peildatum  |
      | peildatum is een dag voor onzekerheidsperiode maand                       | 20210500      | 2021-04-30 |
      | peildatum is een dag voor onzekerheidsperiode jaar                        | 20210000      | 2020-12-31 |
      | peildatum is datum aanvang volgende binnen onzekerheidsperiode maand      | 20210500      | 2021-05-26 |
      | peildatum na datum aanvang volgende binnen onzekerheidsperiode maand      | 20210500      | 2021-05-28 |
      | peildatum na datum aanvang volgende binnen onzekerheidsperiode jaar       | 20210000      | 2021-11-03 |
      | peildatum na onzekerheidsperiode maand                                    | 20210500      | 2021-06-03 |
      | peildatum na onzekerheidsperiode jaar                                     | 20210000      | 2022-03-15 |
      | datum aanvang is volledig onbekend en peildatum is datum aanvang volgende | 00000000      | 2021-05-26 |
      | datum aanvang is volledig onbekend en peildatum na datum aanvang volgende | 00000000      | 2023-03-27 |

    Abstract Scenario: volgende verblijfplaats in onzekerheidsperiode, er is een andere bewoner en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | scenario                                                                  | datum aanvang | peildatum  | periode tot |
      | peildatum is een dag voor onzekerheidsperiode maand                       | 20210500      | 2021-04-30 | 2021-05-01  |
      | peildatum is een dag voor onzekerheidsperiode jaar                        | 20210000      | 2020-12-31 | 2021-01-01  |
      | peildatum is datum aanvang volgende binnen onzekerheidsperiode maand      | 20210500      | 2021-05-26 | 2021-05-27  |
      | peildatum na datum aanvang volgende binnen onzekerheidsperiode maand      | 20210500      | 2021-05-28 | 2021-05-29  |
      | peildatum na datum aanvang volgende binnen onzekerheidsperiode jaar       | 20210000      | 2021-11-03 | 2021-11-04  |
      | peildatum na onzekerheidsperiode maand                                    | 20210500      | 2021-06-03 | 2021-06-04  |
      | peildatum na onzekerheidsperiode jaar                                     | 20210000      | 2022-03-15 | 2022-03-16  |
      | datum aanvang is volledig onbekend en peildatum is datum aanvang volgende | 00000000      | 2021-05-26 | 2021-05-27  |
      | datum aanvang is volledig onbekend en peildatum na datum aanvang volgende | 00000000      | 2023-03-27 | 2023-03-28  |

    Abstract Scenario: vorige verblijfplaats ligt in onzekerheidsperiode en er is een volgende en daaropvolgende verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                                                            | datum aanvang | peildatum  | periode tot |
      | peildatum is dag na aanvang vorige binnen onzekerheidsperiode maand                     | 20210500      | 2021-05-17 | 2021-05-18  |
      | peildatum is dag na aanvang vorige binnen onzekerheidsperiode jaar                      | 20210000      | 2021-05-17 | 2021-05-18  |
      | peildatum is dag na aanvang vorige en datum aanvang gevraagde is volledig onbekend      | 00000000      | 2021-05-17 | 2021-05-18  |
      | peildatum is laatste dag onzekerheidsperiode maand                                      | 20210500      | 2021-05-31 | 2021-06-01  |
      | peildatum is laatste dag onzekerheidsperiode jaar                                       | 20210000      | 2021-12-31 | 2022-01-01  |
      | peildatum is een dag voor aanvang volgende datum aanvang gevraagde is volledig onbekend | 00000000      | 2022-07-29 | 2022-07-30  |

    Abstract Scenario: vorige verblijfplaats ligt in onzekerheidsperiode en er is een volgende en daaropvolgende verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                         | datum aanvang | peildatum  | periode tot |
      | peildatum is eerste dag na onzekerheidsperiode maand | 20210500      | 2021-06-01 | 2021-06-02  |
      | peildatum is eerste dag na onzekerheidsperiode jaar  | 20210000      | 2022-01-01 | 2022-01-02  |
      | peildatum is een dag voor aanvang volgende           | 20210500      | 2022-07-29 | 2022-07-30  |
      | peildatum is een dag voor aanvang volgende           | 20210000      | 2022-07-29 | 2022-07-30  |
      
    Abstract Scenario: vorige verblijfplaats ligt in onzekerheidsperiode en er is een volgende en daaropvolgende verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                            | datum aanvang | peildatum  |
      | peildatum is datum aanvang vorige       | 20210500      | 2021-05-16 |
      | peildatum is datum aanvang volgende     | 20210500      | 2022-07-30 |
      | peildatum ligt voor aanvang vorige      | 20210500      | 2021-05-03 |
      | peildatum ligt voor onzekerheidsperiode | 20210500      | 2021-01-01 |
      | peildatum is datum aanvang vorige       | 20210000      | 2021-05-16 |
      | peildatum is datum aanvang volgende     | 20210000      | 2022-07-30 |
      | peildatum ligt voor aanvang vorige      | 20210000      | 2021-05-03 |
      | peildatum ligt voor onzekerheidsperiode | 20210000      | 2020-07-01 |
      | peildatum is datum aanvang vorige       | 00000000      | 2021-05-16 |
      | peildatum is datum aanvang volgende     | 00000000      | 2022-07-30 |
      | peildatum ligt na aanvang volgende      | 00000000      | 2023-01-01 |
      | peildatum ligt voor aanvang vorige      | 00000000      | 2021-05-03 |

    Abstract Scenario: vorige verblijfplaats ligt in onzekerheidsperiode en er is een volgende en daaropvolgende verblijfplaats, er is een andere bewoner en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | omschrijving                            | datum aanvang | peildatum  | periode tot |
      | peildatum is datum aanvang vorige       | 20210500      | 2021-05-16 | 2021-05-17  |
      | peildatum is datum aanvang volgende     | 20210500      | 2022-07-30 | 2022-07-31  |
      | peildatum ligt voor aanvang vorige      | 20210500      | 2021-05-03 | 2021-05-04  |
      | peildatum ligt voor onzekerheidsperiode | 20210500      | 2021-01-01 | 2021-01-02  |
      | peildatum is datum aanvang vorige       | 20210000      | 2021-05-16 | 2021-05-17  |
      | peildatum is datum aanvang volgende     | 20210000      | 2022-07-30 | 2022-07-31  |
      | peildatum ligt voor aanvang vorige      | 20210000      | 2021-05-03 | 2021-05-04  |
      | peildatum ligt voor onzekerheidsperiode | 20210000      | 2020-11-01 | 2020-11-02  |
      | peildatum is datum aanvang vorige       | 00000000      | 2021-05-16 | 2021-05-17  |
      | peildatum is datum aanvang volgende     | 00000000      | 2022-07-30 | 2022-07-31  |
      | peildatum ligt na aanvang volgende      | 00000000      | 2023-01-01 | 2023-01-02  |
      | peildatum ligt voor aanvang vorige      | 00000000      | 2021-05-03 | 2021-05-04  |

  Rule: een persoon is mogelijke bewoner tijdens de onzekerheidsperiode van de datum aanvang volgende verblijf en bewoner daarvoor

    Abstract Scenario: aanvang volgende verblijf is gedeeltelijk onbekend en het daaropvolgende verblijf begint buiten de onzekerheidsperiode en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230210                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                       | datum aanvang volgende | peildatum  | periode tot |
      | peildatum ligt dag voor onzekerheidsperiode maaand | 20210700               | 2021-06-30 | 2021-07-01  |
      | peildatum ligt dag voor onzekerheidsperiode jaar   | 20220000               | 2021-12-31 | 2022-01-01  |

    Abstract Scenario: aanvang volgende verblijf is geheel/gedeeltelijk onbekend en het daaropvolgende verblijf begint buiten de onzekerheidsperiode en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230210                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                       | datum aanvang volgende | peildatum  | periode tot |
      | peildatum is eerste dag onzekerheidsperiode maand  | 20210700               | 2021-07-01 | 2021-07-02  |
      | peildatum is laatste dag onzekerheidsperiode maand | 20210700               | 2021-07-31 | 2021-08-01  |
      | peildatum is eerste dag onzekerheidsperiode jaar   | 20210000               | 2021-05-27 | 2021-05-28  |
      | peildatum is eerste dag onzekerheidsperiode jaar   | 20220000               | 2022-01-01 | 2022-01-02  |
      | peildatum is laatste dag onzekerheidsperiode jaar  | 20210000               | 2021-12-31 | 2022-01-01  |
      | aanvang volgende is geheel onbekend                | 00000000               | 2022-04-30 | 2022-05-01  |

    Abstract Scenario: aanvang volgende verblijf is gedeeltelijk onbekend en het daaropvolgende verblijf begint buiten de onzekerheidsperiode en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230210                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                | datum aanvang volgende | peildatum  | periode tot |
      | peildatum ligt voor datum aanvang           | 20210700               | 2021-05-25 | 2021-05-26  |
      | peildatum ligt na onzekerheidsperiode maand | 20210700               | 2021-08-01 | 2021-08-02  |
      | peildatum ligt na onzekerheidsperiode jaar  | 20210000               | 2022-01-01 | 2022-01-02  |

    Abstract Scenario: aanvang volgende verblijf is gedeeltelijk onbekend en het daaropvolgende verblijf begint buiten de onzekerheidsperiode, er is een andere bewoner en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230210                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | omschrijving                                | datum aanvang volgende | peildatum  | periode tot |
      | peildatum ligt voor datum aanvang           | 20210700               | 2021-05-25 | 2021-05-26  |
      | peildatum ligt na onzekerheidsperiode maand | 20210700               | 2021-08-01 | 2021-08-02  |
      | peildatum ligt na onzekerheidsperiode jaar  | 20210000               | 2022-01-01 | 2022-01-02  |

    Abstract Scenario: aanvang gevraagd verblijf en aanvang volgend verblijf zijn onbekend en overlappen (dus er is geen periode van zekere bewoning)
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang gevraagde>          |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230210                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang gevraagde | datum aanvang volgende | peildatum  | periode tot |
      | 20210700                | 20210700               | 2021-07-01 | 2021-07-02  |
      | 20210700                | 20210700               | 2021-07-15 | 2021-07-16  |
      | 20210700                | 20210700               | 2021-07-31 | 2021-08-01  |
      | 20210000                | 20210700               | 2021-01-01 | 2021-01-02  |
      | 20210000                | 20210700               | 2021-07-01 | 2021-07-02  |
      | 20210000                | 20210700               | 2021-07-31 | 2021-08-01  |
      | 00000000                | 20210700               | 2020-01-01 | 2020-01-02  |
      | 00000000                | 20210700               | 2021-07-01 | 2021-07-02  |
      | 00000000                | 20210700               | 2021-07-31 | 2021-08-01  |
      | 20210700                | 20210000               | 2021-07-01 | 2021-07-02  |
      | 20210700                | 20210000               | 2021-07-31 | 2021-08-01  |
      | 20210700                | 20210000               | 2021-08-01 | 2021-08-02  |
      | 20210700                | 20210000               | 2021-11-04 | 2021-11-05  |
      | 20210700                | 20210000               | 2021-12-31 | 2022-01-01  |
      | 20210000                | 20210000               | 2021-01-01 | 2021-01-02  |
      | 20210000                | 20210000               | 2021-07-30 | 2021-07-31  |
      | 20210000                | 20210000               | 2021-12-31 | 2022-01-01  |
      | 00000000                | 20210000               | 2020-01-01 | 2020-01-02  |
      | 00000000                | 20210000               | 2020-12-31 | 2021-01-01  |
      | 00000000                | 20210000               | 2021-01-01 | 2021-01-02  |
      | 00000000                | 20210000               | 2021-12-31 | 2022-01-01  |
      | 20210700                | 00000000               | 2021-07-01 | 2021-07-02  |
      | 20210700                | 00000000               | 2021-07-31 | 2021-08-01  |
      | 20210700                | 00000000               | 2021-08-01 | 2021-08-02  |
      | 20210700                | 00000000               | 2022-07-01 | 2022-07-02  |
      | 20210000                | 00000000               | 2021-01-01 | 2021-01-02  |
      | 20210000                | 00000000               | 2021-12-31 | 2022-01-01  |
      | 20210000                | 00000000               | 2022-01-01 | 2022-01-02  |
      | 00000000                | 00000000               | 2020-01-01 | 2020-01-02  |
      | 00000000                | 00000000               | 2023-01-01 | 2023-01-02  |

  Rule: een persoon is zeker geen bewoner op of voor de datum aanvang vorige verblijf

    Abstract Scenario: <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang vorige>             |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang gevraagde>          |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                          | datum aanvang vorige | datum aanvang gevraagde | peildatum  | periode tot |
      | vorige verblijf voor onzekerheidsperiode                          | 20180210             | 20210500                | 2021-05-01 | 2021-05-02  |
      | vorige verblijf voor onzekerheidsperiode                          | 20180210             | 20210000                | 2021-01-01 | 2021-01-02  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210500                | 2021-05-17 | 2021-05-18  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210000                | 2021-05-17 | 2021-05-18  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 00000000                | 2021-05-17 | 2021-05-18  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210500                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210500                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210500                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210000                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210000                | 2021-01-01 | 2021-01-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210000                | 2021-01-01 | 2021-01-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 00000000                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 00000000                | 2021-01-01 | 2021-01-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 00000000                | 2018-01-01 | 2018-01-02  |
    
    Abstract Scenario: <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang vorige>             |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang gevraagde>          |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                                         | datum aanvang vorige | datum aanvang gevraagde | peildatum  |
      | vorig verblijf in onzekerheidsperiode maand en peildatum is datum aanvang vorige | 20210516             | 20210500                | 2021-05-16 |
      | vorig verblijf in onzekerheidsperiode maand en peildat voor aanvang vorige       | 20210516             | 20210500                | 2021-05-03 |
      | vorig verblijf in onzekerheidsperiode jaar en peildatum is datum aanvang vorige  | 20210516             | 20210000                | 2021-05-16 |
      | vorig verblijf in onzekerheidsperiode jaar en peildat voor aanvang vorige        | 20210516             | 20210000                | 2021-03-14 |
      | vorige en gevraagde gelijk en peildatum ligt voor onzekerheidsperiode maand      | 20210500             | 20210500                | 2021-04-30 |
      | vorige overlapt gevraagde en peildatum voor maand gevraagde                      | 20210000             | 20210500                | 2021-04-30 |
      | vorige volledig onbekend en peildatum voor maand gevraagde                       | 00000000             | 20210500                | 2021-04-30 |
      | vorige is maand binnen jaar gevraagde en peildatum voor maand vorige             | 20210500             | 20210000                | 2021-04-30 |
      | vorige en gevraagde gelijk en peildatum ligt voor onzekerheidsperiode jaar       | 20210000             | 20210000                | 2020-12-31 |
      | vorige volledig onbekend en peildatum voor jaar gevraagde                        | 00000000             | 20210000                | 2020-12-31 |
      | vorige en gevraagde gelijk en peildatum ligt voor onzekerheidsperiode jaar       | 20210000             | 20210000                | 2020-12-31 |
      
    Abstract Scenario: remigratie en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180730                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | <datum aanvang vorige>                 | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang gevraagde>          |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                          | datum aanvang vorige | datum aanvang gevraagde | peildatum  | periode tot |
      | vorige verblijf voor onzekerheidsperiode                          | 20180210             | 20210500                | 2021-05-01 | 2021-05-02  |
      | vorige verblijf voor onzekerheidsperiode                          | 20180210             | 20210000                | 2021-01-01 | 2021-01-02  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210500                | 2021-05-17 | 2021-05-18  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210000                | 2021-05-17 | 2021-05-18  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 00000000                | 2021-05-17 | 2021-05-18  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210500                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210500                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210500                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210000                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210000                | 2021-01-01 | 2021-01-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210000                | 2021-01-01 | 2021-01-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 00000000                | 2021-05-01 | 2021-05-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 00000000                | 2021-01-01 | 2021-01-02  |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 00000000                | 2018-01-01 | 2018-01-02  |

    Abstract Scenario: remigratie en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180730                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | <datum aanvang vorige>                 | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang gevraagde>          |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                          | datum aanvang vorige | datum aanvang gevraagde | peildatum  |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210500                | 2021-05-16 |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210500                | 2021-05-03 |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210000                | 2021-05-16 |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210000                | 2021-03-14 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210500                | 2021-04-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210500                | 2021-04-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210500                | 2021-04-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210000                | 2021-04-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210000                | 2020-12-31 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210000                | 2020-12-31 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20200000                | 2020-12-31 |

  Rule: een persoon is zeker geen bewoner vanaf datum aanvang van het verblijf volgend op het volgende verblijf
  
    Abstract Scenario: aanvang volgende verblijf is geheel/gedeeltelijk onbekend en het daaropvolgende verblijf valt binnen de onzekerheidsperiode van het volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang daaropvolgende>     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | datum aanvang daaropvolgende | peildatum  | periode tot |
      | 20210700               | 20210730                     | 2021-07-29 | 2021-07-30  |
      | 20220000               | 20221014                     | 2022-10-13 | 2022-10-14  |
      | 00000000               | 20221014                     | 2022-10-13 | 2022-10-14  |
      | 20210700               | 20210700                     | 2021-07-31 | 2021-08-01  |
      | 20210700               | 00000000                     | 2021-07-31 | 2021-08-01  |
      | 20220000               | 20221000                     | 2022-10-31 | 2022-11-01  |
      | 20220000               | 20220000                     | 2022-12-31 | 2023-01-01  |
      | 20220000               | 00000000                     | 2022-12-31 | 2023-01-01  |
      | 00000000               | 20221000                     | 2022-10-31 | 2022-11-01  |
      | 00000000               | 20220000                     | 2022-12-31 | 2023-01-01  |

    #212 (wordt niet geleverd in v2.0.x)
    Abstract Scenario: aanvang volgende verblijf is geheel/gedeeltelijk onbekend en het daaropvolgende verblijf valt binnen de onzekerheidsperiode van het volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang daaropvolgende>     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum aanvang volgende | datum aanvang daaropvolgende | peildatum  |
      | 20210700               | 20210730                     | 2021-08-01 |
      #| 20210700               | 20210730                     | 2021-07-30 |
      #| 20210700               | 20210730                     | 2021-07-31 |
      #| 20220000               | 20221014                     | 2022-10-14 |
      #| 00000000               | 20221014                     | 2022-10-14 |
      | 20210700 | 20210700 | 2021-08-01 |
      | 20210700 | 00000000 | 2021-08-01 |
      #| 20220000               | 20221000                     | 2022-11-01 |
      | 20220000 | 20220000 | 2023-01-01 |
      | 20220000 | 00000000 | 2023-01-01 |
      #| 00000000               | 20221000                     | 2022-11-01 |
      #| 00000000               | 20220000                     | 2023-01-01 |

  Rule: een persoon is geen bewoner meer vanaf de datum opschorting

    Abstract Scenario: persoon overlijdt in onzekerheidsperiode aanvang adreshouding
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20181014                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210314                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | peildatum  | periode tot |
      | 20210300      | 2021-03-07 | 2021-03-08  |
      | 20210300      | 2021-03-13 | 2021-03-14  |
      | 20210000      | 2021-02-09 | 2021-02-10  |
      | 00000000      | 2021-03-13 | 2021-03-14  |

    Abstract Scenario: persoon overlijdt in onzekerheidsperiode aanvang adreshouding
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20181014                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210314                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum aanvang | peildatum  |
      | 20210300      | 2021-03-14 |
      | 20210300      | 2021-03-27 |
      | 20210000      | 2021-03-14 |
      | 20210000      | 2021-11-02 |
      | 00000000      | 2021-03-14 |
      | 00000000      | 2022-01-19 |

    Abstract Scenario: persoon overlijdt in onzekerheidsperiode aanvang adreshouding en vorige verblijf ligt in onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210306                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210314                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | peildatum  | periode tot |
      | 20210300      | 2021-03-07 | 2021-03-08  |
      | 20210300      | 2021-03-13 | 2021-03-14  |
      | 20210000      | 2021-03-07 | 2021-03-08  |
      | 20210000      | 2021-03-13 | 2021-03-14  |
      | 00000000      | 2021-03-07 | 2021-03-08  |
      | 00000000      | 2021-03-13 | 2021-03-14  |

    Abstract Scenario: persoon overlijdt in onzekerheidsperiode aanvang adreshouding en vorige verblijf ligt in onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210306                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210314                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum aanvang | peildatum  |
      | 20210300      | 2021-02-19 |
      | 20210300      | 2021-03-03 |
      | 20210300      | 2021-03-06 |
      | 20210300      | 2021-03-14 |
      | 20210300      | 2021-03-27 |
      | 20210000      | 2020-11-04 |
      | 20210000      | 2021-03-03 |
      | 20210000      | 2021-03-06 |
      | 20210000      | 2021-03-14 |
      | 20210000      | 2021-03-27 |
      | 00000000      | 2021-03-03 |
      | 00000000      | 2021-03-06 |
      | 00000000      | 2021-03-14 |
      | 00000000      | 2021-03-27 |

    Abstract Scenario: persoon overlijdt in onzekerheidsperiode volgende adreshouding en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20181014                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | <datum opschorting>                  | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                                      | datum aanvang volgende | datum opschorting | peildatum  | periode tot |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende     | 20220700               | 20220714          | 2022-07-01 | 2022-07-02  |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende     | 20220700               | 20220714          | 2022-07-13 | 2022-07-14  |
      | datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende       | 20220700               | 20220731          | 2022-07-29 | 2022-07-30  |
      | datum opschorting ligt na onzekerheidsperiode tijdens verblijf daaropvolgende | 20220700               | 20220819          | 2022-07-29 | 2022-07-30  |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende     | 20220000               | 20220714          | 2022-07-13 | 2022-07-14  |
      | datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende       | 20220000               | 20220819          | 2022-07-29 | 2022-07-30  |
      | datum opschorting ligt na onzekerheidsperiode tijdens verblijf daaropvolgende | 20220000               | 20230218          | 2022-07-29 | 2022-07-30  |

    #212 (daaropvolgende: niet in v2.0.x)
    Abstract Scenario: persoon overlijdt in onzekerheidsperiode volgende adreshouding en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20181014                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | <datum opschorting>                  | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                                  | datum aanvang volgende | datum opschorting | peildatum  |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende | 20220700               | 20220714          | 2022-07-14 |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende | 20220700               | 20220714          | 2022-07-16 |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende | 20220700               | 20220714          | 2022-07-31 |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende | 20220700               | 20220714          | 2022-08-01 |
      #| datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende       | 20220700               | 20220731          | 2022-07-30 |
      | datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende | 20220700 | 20220731 | 2022-07-31 |
      | datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende | 20220700 | 20220731 | 2022-08-01 |
      #| datum opschorting ligt na onzekerheidsperiode tijdens verblijf daaropvolgende | 20220700               | 20220819          | 2022-07-30 |
      | datum opschorting ligt na onzekerheidsperiode tijdens verblijf daaropvolgende | 20220700 | 20220819 | 2022-08-01 |
      | datum opschorting ligt na onzekerheidsperiode tijdens verblijf daaropvolgende | 20220700 | 20220819 | 2022-08-20 |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende     | 20220000 | 20220714 | 2022-07-14 |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende     | 20220000 | 20220714 | 2022-07-30 |
      | datum opschorting ligt in onzekerheidsperiode voor aanvang daaropvolgende     | 20220000 | 20220714 | 2023-01-03 |
      #| datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende       | 20220000               | 20220819          | 2022-07-30 |
      #| datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende       | 20220000               | 20220819          | 2022-07-31 |
      | datum opschorting ligt in onzekerheidsperiode na aanvang daaropvolgende | 20220000 | 20220819 | 2022-08-19 |
      #| datum opschorting ligt na onzekerheidsperiode tijdens verblijf daaropvolgende | 20220000               | 20230218          | 2022-07-30 |

  Rule: onjuist wordt genegeerd

    Abstract Scenario: datum aanvang is gecorrigeerd <scenario> en peildatum ligt in de nieuwe onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum>                   |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum>                     | W                     |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                                           | onjuiste datum | nieuwe datum | peildatum  | periode tot |
      | naar latere onzekerheidperiode                                                     | 20210500       | 20210700     | 2021-07-01 | 2021-07-02  |
      | naar eerdere onzekerheidperiode waarbij vorige voor onzekerheidsperiode ligt       | 20210700       | 20210600     | 2021-06-01 | 2021-06-02  |
      | naar eerdere onzekerheidperiode waarbij vorige in onzekerheidsperiode ligt         | 20210700       | 20210500     | 2021-05-17 | 2021-05-18  |
      | van maanddatum naar jaardatum waarbij vorige in onzekerheidsperiode ligt           | 20210700       | 20210000     | 2021-05-17 | 2021-05-18  |
      | van maanddatum naar jaardatum waarbij vorige in onzekerheidsperiode ligt           | 20210700       | 20210000     | 2021-08-09 | 2021-08-10  |
      | van echte datum naar onbekende datum waarbij vorige voor onzekerheidsperiode ligt  | 20210529       | 20210700     | 2021-07-01 | 2021-07-02  |
      | van echte datum naar onbekende datum waarbij vorige in de onzekerheidsperiode ligt | 20210529       | 20210500     | 2021-05-29 | 2021-05-30  |
      | van echte datum naar onbekende datum waarbij vorige in de onzekerheidsperiode ligt | 20210529       | 20210000     | 2021-05-29 | 2021-05-30  |

    Abstract Scenario: datum aanvang is gecorrigeerd <scenario> en peildatum ligt na de nieuwe onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum>                   |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum>                     | W                     |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                                          | onjuiste datum | nieuwe datum | peildatum  | periode tot |
      | naar latere onzekerheidperiode                                                    | 20210500       | 20210700     | 2021-08-01 | 2021-08-02  |
      | naar eerdere onzekerheidperiode waarbij vorige voor onzekerheidsperiode ligt      | 20210700       | 20210600     | 2021-07-01 | 2021-07-02  |
      | naar eerdere onzekerheidperiode waarbij vorige in onzekerheidsperiode ligt        | 20210700       | 20210500     | 2021-07-01 | 2021-07-02  |
      | van echte datum naar onbekende datum waarbij vorige voor onzekerheidsperiode ligt | 20210529       | 20210700     | 2021-08-01 | 2021-08-02  |
      
    Abstract Scenario: datum aanvang is gecorrigeerd <scenario> en peildatum ligt voor de nieuwe onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum>                   |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum>                     | W                     |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                                           | onjuiste datum | nieuwe datum | peildatum  |
      | naar latere onzekerheidperiode                                                     | 20210500       | 20210700     | 2021-05-16 |
      | naar latere onzekerheidperiode                                                     | 20210500       | 20210700     | 2021-05-17 |
      | naar latere onzekerheidperiode                                                     | 20210500       | 20210700     | 2021-06-30 |
      | naar eerdere onzekerheidperiode waarbij vorige voor onzekerheidsperiode ligt       | 20210700       | 20210600     | 2021-05-31 |
      | naar eerdere onzekerheidperiode waarbij vorige in onzekerheidsperiode ligt         | 20210700       | 20210500     | 2021-05-16 |
      | van maanddatum naar jaardatum waarbij vorige in onzekerheidsperiode ligt           | 20210700       | 20210000     | 2021-05-16 |
      | van echte datum naar onbekende datum waarbij vorige voor onzekerheidsperiode ligt  | 20210529       | 20210700     | 2021-05-29 |
      | van echte datum naar onbekende datum waarbij vorige voor onzekerheidsperiode ligt  | 20210529       | 20210700     | 2021-06-30 |
      | van echte datum naar onbekende datum waarbij vorige in de onzekerheidsperiode ligt | 20210529       | 20210500     | 2021-05-16 |
      | van echte datum naar onbekende datum waarbij vorige in de onzekerheidsperiode ligt | 20210529       | 20210000     | 2021-05-16 |

    Abstract Scenario: datum aanvang volgende is gecorrigeerd <scenario> en peildatum ligt voor de nieuwe onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum volgende>          |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum volgende>            | W                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                      | onjuiste datum volgende | nieuwe datum volgende | peildatum  | periode tot |
      | naar latere onzekerheidsperiode               | 20210500                | 20210700              | 2021-05-01 | 2021-05-02  |
      | naar eerdere onzekerheidsperiode              | 20210500                | 20210700              | 2021-06-30 | 2021-07-01  |
      | van jaardatum naar maanddatum van zelfde jaar | 20210000                | 20210500              | 2021-04-01 | 2021-04-02  |
      | van echte datum naar onbekende datum          | 20210730                | 20210700              | 2021-06-30 | 2021-07-01  |

    Abstract Scenario: datum aanvang volgende is gecorrigeerd <scenario> en peildatum ligt in de nieuwe onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum volgende>          |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum volgende>            | W                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                      | onjuiste datum volgende | nieuwe datum volgende | peildatum  | periode tot |
      | naar latere onzekerheidsperiode               | 20210500                | 20210700              | 2021-07-01 | 2021-07-02  |
      | naar eerdere onzekerheidsperiode              | 20210700                | 20210500              | 2021-05-01 | 2021-05-02  |
      | van maanddatum naar jaardatum                 | 20210500                | 20210000              | 2021-04-01 | 2021-04-02  |
      | van maanddatum naar jaardatum                 | 20210500                | 20210000              | 2021-06-01 | 2021-06-02  |
      | van jaardatum naar maanddatum van zelfde jaar | 20210000                | 20210500              | 2021-05-01 | 2021-05-02  |
      | van echte datum naar onbekende datum          | 20210730                | 20210700              | 2021-07-01 | 2021-07-02  |
      | van echte datum naar onbekende datum          | 20210730                | 20210700              | 2021-07-31 | 2021-08-01  |

    Abstract Scenario: datum aanvang volgende is gecorrigeerd <scenario> en peildatum ligt na de nieuwe onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum volgende>          |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum volgende>            | W                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20231014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                      | onjuiste datum volgende | nieuwe datum volgende | peildatum  |
      | naar latere onzekerheidsperiode               | 20210500                | 20210700              | 2021-08-01 |
      | naar eerdere onzekerheidsperiode              | 20210700                | 20210500              | 2021-06-01 |
      | van maanddatum naar jaardatum                 | 20210500                | 20210000              | 2022-01-01 |
      | van jaardatum naar maanddatum van zelfde jaar | 20210000                | 20210500              | 2021-06-01 |
      | van echte datum naar onbekende datum          | 20210730                | 20210700              | 2021-08-01 |

    Scenario: datum aanvang daaropvolgende is gecorrigeerd en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180730                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20201014                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum volgende>                   |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum daaropvolgende>    |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum daaropvolgende>      | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                      | datum volgende | onjuiste datum daaropvolgende | nieuwe datum daaropvolgende | peildatum  | periode tot |
      | daaropvolgende lag binnen onzekerheidsperiode en nu niet meer | 20210500       | 20210526                      | 20220314                    | 2021-05-26 | 2021-05-27  |
      | daaropvolgende lag binnen onzekerheidsperiode en nu niet meer | 20210000       | 20210526                      | 20220314                    | 2021-05-26 | 2021-05-27  |
      | daaropvolgende lag binnen onzekerheidsperiode en nu niet meer | 00000000       | 20210526                      | 20220314                    | 2021-05-26 | 2021-05-27  |

    #212 (daaropvolgende: niet in v2.0.x)
    Scenario: datum aanvang daaropvolgende is gecorrigeerd en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180730                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20201014                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum volgende>                   |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <onjuiste datum daaropvolgende>    |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | <nieuwe datum daaropvolgende>      | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario | datum volgende | onjuiste datum daaropvolgende | nieuwe datum daaropvolgende | peildatum | periode tot |
      #| daaropvolgende lag na onzekerheidsperiode en nu erbinnen | 20210500       | 20220314                      | 20210526                    | 2021-05-26 | 2021-05-27  |
      #| daaropvolgende lag na onzekerheidsperiode en nu erbinnen | 20210000       | 20220314                      | 20210526                    | 2021-05-26 | 2021-05-27  |
      #| daaropvolgende is vervroegd                              | 00000000       | 20220314                      | 20210526                    | 2021-05-26 | 2021-05-27  |