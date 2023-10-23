#language: nl

@gba
Functionaliteit: bewoning in periode met geheel of gedeeltelijk onbekende datums

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

    Abstract Scenario: eerste en enige verblijfplaats met gedeeltelijk onbekende datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner | periode bewoner           |
      | 20210500      | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2023-01-01 |
      | 20210000      | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 |

    Scenario: eerste en enige verblijfplaats met volledig onbekende datum aanvang
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2021-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-01-01 tot 2021-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Abstract Scenario: volgende verblijfplaats na onzekerheidsperiode en binnen gevraagde periode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner | periode bewoner           |
      | 20210500      | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-10-14 |
      | 20210000      | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2022-10-14 |

    Abstract Scenario: volgende verblijfplaats na onzekerheidsperiode en na gevraagde periode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2022-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner | periode bewoner           |
      | 20210500      | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-01-01 |
      | 20210000      | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2022-01-01 |

    Abstract Scenario: volgende verblijfplaats in onzekerheidsperiode en binnen gevraagde periode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2022-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner |
      | 20210500      | 2021-05-01 tot 2021-05-26 |
      | 20210000      | 2021-01-01 tot 2021-05-26 |
      | 00000000      | 2020-01-01 tot 2021-05-26 |

    Abstract Scenario: volgende verblijfplaats in onzekerheidsperiode en na gevraagde periode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2021-05-16         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner |
      | 20210500      | 2021-05-01 tot 2021-05-16 |
      | 20210000      | 2021-01-01 tot 2021-05-16 |
      | 00000000      | 2020-01-01 tot 2021-05-16 |

    Abstract Scenario: vorige verblijfplaats ligt in onzekerheidsperiode en er is een volgende en daaropvolgende verblijfplaats
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
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner | periode bewoner           |
      | 20210500      | 2021-05-17 tot 2021-06-01 | 2021-06-01 tot 2022-07-30 |
      | 20210000      | 2021-05-17 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |

    Scenario: volledig onbekende datum aanvang en er is een vorige, volgende en daaropvolgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 00000000                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-17 tot 2022-07-30 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

  Rule: een persoon is mogelijke bewoner tijdens de onzekerheidsperiode van de datum aanvang volgende verblijf en bewoner daarvoor

    Abstract Scenario: aanvang volgende verblijf is gedeeltelijk onbekend en het daaropvolgende verblijf begint buiten de onzekerheidsperiode
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
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2023-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | periode bewoner           | periode mogelijke bewoner |
      | 20210700               | 2021-05-26 tot 2021-07-01 | 2021-07-01 tot 2021-08-01 |
      | 20220000               | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 |

    Scenario: aanvang volgende verblijf is geheel onbekend en er is geen daaropvolgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2023-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-26 tot 2021-05-27 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-27 tot 2023-07-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Abstract Scenario: aanvang volgende gevraagd verblijf en aanvang volgend verblijf zijn onbekend en overlappen (dus er is geen periode van zekere bewoning)
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
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang gevraagde | datum aanvang volgende | periode mogelijke bewoner |
      | 20210700                | 20210700               | 2021-07-01 tot 2021-08-01 |
      | 20210000                | 20210700               | 2021-01-01 tot 2021-08-01 | 
      | 00000000                | 20210700               | 2020-01-01 tot 2021-08-01 | 
      | 20210700                | 20210000               | 2021-07-01 tot 2022-01-01 | 
      | 20210000                | 20210000               | 2021-01-01 tot 2022-01-01 | 
      | 00000000                | 20210000               | 2020-01-01 tot 2022-01-01 | 
      | 20210700                | 00000000               | 2021-07-01 tot 2023-01-01 | 
      | 20210000                | 00000000               | 2021-01-01 tot 2023-01-01 | 
      | 00000000                | 00000000               | 2020-01-01 tot 2023-01-01 |

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
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                          | datum aanvang vorige | datum aanvang gevraagde | periode mogelijke bewoner | periode bewoner           |
      | vorige verblijf voor onzekerheidsperiode                          | 20180210             | 20210500                | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-07-30 |
      | vorige verblijf voor onzekerheidsperiode                          | 20180210             | 20210000                | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210500                | 2021-05-17 tot 2021-06-01 | 2021-06-01 tot 2022-07-30 |
      | vorig verblijf in onzekerheidsperiode                             | 20210516             | 20210000                | 2021-05-17 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210500                | 2021-05-02 tot 2021-06-01 | 2021-06-01 tot 2022-07-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210500                | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-07-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210500                | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-07-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210500             | 20210000                | 2021-05-02 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 20210000             | 20210000                | 2021-01-02 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      | onzekerheidsperiode vorige overlapt onzekerheidsperiode gevraagde | 00000000             | 20210000                | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      
    Abstract Scenario: aanvang gevraagde verblijf is volledig onbekend
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
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang vorige | datum aanvang gevraagde | periode mogelijke bewoner |
      | 20210516             | 00000000                | 2021-05-16 tot 2022-07-30 |
      | 20210500             | 00000000                | 2021-05-02 tot 2022-07-30 |
      | 20210000             | 00000000                | 2021-01-02 tot 2022-07-30 |
      | 00000000             | 00000000                | 2020-01-01 tot 2022-07-30 |

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
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2023-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | datum aanvang daaropvolgende | periode bewoner           | periode mogelijke bewoner |
      | 20210700               | 20210730                     | 2021-05-26 tot 2021-07-01 | 2021-07-01 tot 2021-07-30 |
      | 20220000               | 20221014                     | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-10-14 |
      | 00000000               | 20221014                     | 2021-05-26 tot 2021-05-27 | 2021-05-27 tot 2022-10-14 |
      | 20210700               | 20210700                     | 2021-05-26 tot 2021-07-01 | 2021-07-01 tot 2021-08-01 |
      | 20210700               | 20210000                     | 2021-05-26 tot 2021-07-01 | 2021-07-01 tot 2021-08-01 |
      | 20210700               | 00000000                     | 2021-05-26 tot 2021-07-01 | 2021-07-01 tot 2021-08-01 |
      | 20220000               | 20221000                     | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-11-01 |
      | 20220000               | 20220000                     | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 |
      | 20220000               | 00000000                     | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 |
      | 00000000               | 20221000                     | 2021-05-26 tot 2021-05-27 | 2021-05-27 tot 2022-11-01 |
      | 00000000               | 20220000                     | 2021-05-26 tot 2021-05-27 | 2021-05-27 tot 2023-01-01 |
      | 00000000               | 00000000                     | 2021-05-26 tot 2021-05-27 | 2021-05-27 tot 2023-07-01 |

  Rule: geleverde bewoning wordt beperkt door de gevraagde periode

    Abstract Scenario: aanvang adreshouding is geheel/gedeeltelijk onbekend en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | 2022-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                     | datum aanvang | datum van  | periode mogelijke bewoner | periode bewoner           |
      | periode begint voor onzekerheidsperiode                      | 20210500      | 2021-01-01 | 2021-05-17 tot 2021-06-01 | 2021-06-01 tot 2022-07-01 |
      | periode begint in onzekerheidsperiode en voor aanvang vorige | 20210500      | 2021-05-03 | 2021-05-17 tot 2021-06-01 | 2021-06-01 tot 2022-07-01 |
      | periode begint in onzekerheidsperiode en na aanvang vorige   | 20210500      | 2021-05-26 | 2021-05-26 tot 2021-06-01 | 2021-06-01 tot 2022-07-01 |
      | periode begint voor onzekerheidsperiode                      | 20210000      | 2020-07-01 | 2021-05-17 tot 2022-01-01 | 2022-01-01 tot 2022-07-01 |
      | periode begint in onzekerheidsperiode en voor aanvang vorige | 20210000      | 2021-05-03 | 2021-05-17 tot 2022-01-01 | 2022-01-01 tot 2022-07-01 |
      | periode begint in onzekerheidsperiode en na aanvang vorige   | 20210000      | 2021-05-26 | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-07-01 |
      | periode begint in onzekerheidsperiode en voor aanvang vorige | 00000000      | 2021-05-03 | 2021-05-17 tot 2022-01-01 | 2022-01-01 tot 2022-07-01 |
      | periode begint in onzekerheidsperiode en na aanvang vorige   | 00000000      | 2021-05-26 | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-07-01 |

    Abstract Scenario: aanvang adreshouding volgende is geheel/gedeeltelijk onbekend en <scenario>
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
      | 0800                              | 20220730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000002            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                              | datum aanvang volgende | datum tot  | periode bewoner           | periode mogelijke bewoner |
      | periode eindigt na onzekerheidsperiode                                | 20220700               | 2023-01-01 | 2021-05-26 tot 2022-07-01 | 2022-07-01 tot 2022-07-30 |
      | periode eindigt in onzekerheidsperiode en voor aanvang daaropvolgende | 20220700               | 2022-07-15 | 2021-05-26 tot 2022-07-01 | 2022-07-01 tot 2022-07-15 |
      | periode eindigt in onzekerheidsperiode en na aanvang daaropvolgende   | 20220700               | 2022-07-31 | 2021-05-26 tot 2022-07-01 | 2022-07-01 tot 2022-07-30 |
      | periode eindigt na onzekerheidsperiode                                | 20220000               | 2023-07-01 | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      | periode eindigt in onzekerheidsperiode en voor aanvang daaropvolgende | 20220000               | 2022-07-15 | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-07-15 |
      | periode eindigt in onzekerheidsperiode en na aanvang daaropvolgende   | 20220000               | 2022-07-31 | 2021-05-26 tot 2022-01-01 | 2022-01-01 tot 2022-07-30 |
      | periode eindigt in onzekerheidsperiode en voor aanvang daaropvolgende | 00000000               | 2022-07-15 | 2021-05-26 tot 2021-05-27 | 2021-05-27 tot 2022-07-15 |
      | periode eindigt in onzekerheidsperiode en na aanvang daaropvolgende   | 00000000               | 2022-07-31 | 2021-05-26 tot 2021-05-27 | 2021-05-27 tot 2022-07-30 |
  

  Rule: een persoon is geen bewoner meer vanaf de datum opschorting

  Rule: onjuist wordt genegeerd