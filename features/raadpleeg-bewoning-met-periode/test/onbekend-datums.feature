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

    Abstract Scenario: eerste en enige verblijfplaats
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

    Scenario: eerste en enige verblijfplaats
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

    Abstract Scenario: vorige, volgende en daaropvolgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2022-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-26 tot 2021-07-30 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

  Rule: een persoon is mogelijke bewoners tijdens de onzekerheidsperiode van de datum aanvang volgende verblijf en bewoner daarvoor

  Rule: een persoon is zeker geen bewoner op of voor de datum aanvang vorige verblijf

  Rule: een persoon is zeker geen bewoner vanaf datum aanvang van het verblijf volgend op het volgende verblijf