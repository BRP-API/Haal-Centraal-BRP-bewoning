#language: nl

@gba
Functionaliteit: gebeurtenissen met meerdere bewoners in periode met geheel of gedeeltelijk onbekende datums

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
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |

  Rule: Bij de start en na afloop van de onzekerheidsperiode van datum aanvang ontstaat een nieuwe bewoning(samenstelling)

    Abstract Scenario: vorige aanvang ligt voor de onzekerheidsperiode aanvang gevraagde
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-12-01         |
      | datumTot                         | 2022-02-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-12-01 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                      |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                     |
      | 20210000      | 2021-01-01                     | 2022-01-01                     |

    Abstract Scenario: vorige aanvang ligt in onzekerheidsperiode aanvang gevraagde
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-12-01         |
      | datumTot                         | 2022-02-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-12-01 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                      |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-27                     | 2021-06-01                     |
      | 20210000      | 2021-05-27                     | 2022-01-01                     |

    Scenario: onzekerheidsperiodes van verschillende bewoners overlappen
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210000                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210500                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-12-01         |
      | datumTot                         | 2022-02-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-12-01 tot 2021-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2021-05-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-01 tot 2021-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-06-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |

  Rule: Bij de start en na afloop van de onzekerheidsperiode van datum aanvang volgende verblijfplaats ontstaat een nieuwe bewoning(samenstelling), tenzij deze periodes overlappen of direct op elkaar aansluiten

    Scenario: daaropvolgende ligt na onzekerheidsperiode volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20201014                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-07-30 tot 2020-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-10-14 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                      |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500               | 2021-05-01                     | 2021-06-01                     |
      | 20210000               | 2021-01-01                     | 2022-01-01                     |

    Scenario: daaropvolgende ligt in onzekerheidsperiode volgende
    #To Do: #212 (wordt niet geleverd in v2.0.x)

    #217 (voorbeeld met aanvang gevraagde 00000000)
    Scenario: onzekerheidsperiode aanvang en volgende overlappen
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20201014                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                      |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 20210500               | 2021-05-01                     | 2021-06-01                     |
      | 20210500      | 20210000               | 2021-05-01                     | 2022-01-01                     |
      | 20210000      | 20210000               | 2021-01-01                     | 2022-01-01                     |
      | 20210000      | 20210500               | 2021-01-01                     | 2021-06-01                     |
      | 00000000      | 20210500               | 2020-10-15                     | 2021-06-01                     |
      
    Scenario: onzekerheidsperiodes aanvang en volgende zijn aansluitend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20201014                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                      |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 20210600               | 2021-05-01                     | 2021-07-01                     |
      | 20201200      | 20210000               | 2020-12-01                     | 2022-01-01                     |
      | 20210000      | 20220100               | 2021-01-01                     | 2022-02-01                     |
      | 20200000      | 20210000               | 2020-10-15                     | 2022-01-01                     |

  Rule: Als er tijdens de onzekerheidsperiode van een bewoner een andere bewoner in- of uitverhuist, ontstaat op de datum aanvang van de andere bewoner een nieuwe bewoning(samenstelling)

    Abstract Scenario: andere persoon verhuist in tijdens onzekerheidsperiode aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2021-05-26 tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                     |
      | 20210000      | 2021-01-01                     | 2022-01-01                     |

    Abstract Scenario: andere persoon verhuist uit tijdens onzekerheidsperiode aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180430                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2021-05-26 tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                     |
      | 20210000      | 2021-01-01                     | 2022-01-01                     |

    Abstract Scenario: andere persoon verhuist naar buitenland tijdens onzekerheidsperiode aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180430                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | 20210526                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2021-05-26 tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                     |
      | 20210000      | 2021-01-01                     | 2022-01-01                     |

    Abstract Scenario: andere persoon verhuist in tijdens onzekerheidsperiode aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2021-05-26 tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |

      Voorbeelden:
      | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500               | 2021-05-01                     | 2021-06-01                     |
      | 20210000               | 2021-01-01                     | 2022-01-01                     |

    Abstract Scenario: andere persoon verhuist uit tijdens onzekerheidsperiode aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2021-05-26 tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500               | 2021-05-01                     | 2021-06-01                     |
      | 20210000               | 2021-01-01                     | 2022-01-01                     |

    Scenario: andere persoon verhuist met gedeeltelijk onbekende aanvang in tijdens onzekerheidsperiode aanvang met overlappende verschillende onzekerheidsperiodes
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210000                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210500                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-07-30 tot 2021-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2021-05-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-01 tot 2021-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-06-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |

    Scenario: andere persoon verhuist met gedeeltelijk onbekende aanvang in tijdens onzekerheidsperiode aanvang met overlappende gelijke onzekerheidsperiodes
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
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
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                 |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                       |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                           |
      | periode                          | <laatste dag onzekerheidsperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                 |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidsperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                      |
      | 20210000      | 2021-01-01                     | 2022-01-01                      |

    Scenario: andere persoon verhuist met gedeeltelijk onbekende aanvang in tijdens onzekerheidsperiode aanvang met overlappende verschillende onzekerheidsperiodes en vorige binnen onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210000                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210500                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-07-30 tot 2021-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2021-05-17 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-17 tot 2021-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-06-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |

    Scenario: andere persoon verhuist met gedeeltelijk onbekende aanvang uit tijdens onzekerheidsperiode aanvang met overlappende verschillende onzekerheidsperiodes
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210000                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210500                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-07-30 tot 2021-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2021-05-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-01 tot 2021-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-06-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

    Scenario: andere persoon verhuist met gedeeltelijk onbekende aanvang uit tijdens onzekerheidsperiode aanvang volgende met overlappende verschillende onzekerheidsperiodes
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210000                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210500                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-07-30 tot 2021-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2021-05-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-01 tot 2021-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-06-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

  Rule: Als de bijhouding van de persoon tijdens de onzekerheidsperiode wordt opgeschort, ontstaat op de datum opschorting een nieuwe bewoning(samenstelling)

    Abstract Scenario: persoon overlijdt tijdens onzekerheidsperiode aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210511                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-11 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-11 tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode |
      | 20210500      | 2021-05-01                     |
      | 20210000      | 2021-01-01                     |

    Abstract Scenario: bijhouding wordt opgeschort tijdens onzekerheidsperiode aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | <datum aanvang volgende>               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210526                             | R                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-26 tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | eerste dag onzekerheidsperiode |
      | 20210500               | 2021-05-01                     |
      | 20210000               | 2021-01-01                     |

    Abstract Scenario: persoon overlijdt na onzekerheidsperiode volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20220218                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                                                 |
      | periode                          | <eerste dag onzekerheidsperiode> tot <laatste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                                       |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                           |
      | periode                          | <laatste dag onzekerheidsperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                 |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidsperiode |
      | 20210500               | 2021-05-01                     | 2021-06-01                      |
      | 20210000               | 2021-01-01                     | 2022-01-01                      |

    Abstract Scenario: andere persoon overlijdt tijdens onzekerheidsperiode aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20221014                         |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230730                           |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180430                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210511                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-11 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2021-05-11 tot <laatste dag onzekerheidperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <laatste dag onzekerheidperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                     |
      | 20210000      | 2021-01-01                     | 2022-01-01                     |

    Abstract Scenario: andere persoon overlijdt tijdens onzekerheidsperiode aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                         |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | <datum aanvang volgende>               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      En de persoon met burgerservicenummer '000000036' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20180430                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200730                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20210511                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | 2020-07-30 tot <eerste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      | 000000036           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                          |
      | periode                          | <eerste dag onzekerheidsperiode> tot 2021-05-11 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000036           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                           |
      | periode                          | 2021-05-11 tot <laatste dag onzekerheidsperiode> |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                 |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                                           |
      | periode                          | <laatste dag onzekerheidsperiode> tot 2022-10-14 |
      | adresseerbaarObjectIdentificatie | 0800010000000002                                 |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | datum aanvang volgende | eerste dag onzekerheidsperiode | laatste dag onzekerheidsperiode |
      | 20210500               | 2021-05-01                     | 2021-06-01                      |
      | 20210000               | 2021-01-01                     | 2022-01-01                      |
