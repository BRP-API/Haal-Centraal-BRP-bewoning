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
      | 20210500      | 2021-05-01 | 2021-06-01 |
      | 20210000      | 2021-01-01 | 2022-01-01 |

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

  Rule: Bij de start en na afloop van de onzekerheidsperiode van datum aanvang volgende verblijfplaats ontstaat een nieuwe bewoning(samenstelling)

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
      | datum aanvang | eerste dag onzekerheidsperiode | laatste dag onzekerheidperiode |
      | 20210500      | 2021-05-01                     | 2021-06-01                     |
      | 20210000      | 2021-01-01                     | 2022-01-01                     |

    Scenario: daaropvolgende ligt in onzekerheidsperiode volgende

    Scenario: onzekerheidsperiode aanvang en volgende overlappen

  Rule: Als er tijdens de onzekerheidsperiode van een bewoner een andere bewoner in- of uitverhuist, ontstaat op de datum aanvang van de andere bewoner een nieuwe bewoning(samenstelling)

    Scenario: andere persoon verhuist in tijdens onzekerheidsperiode aanvang

    Scenario: andere persoon verhuist uit tijdens onzekerheidsperiode aanvang

    Scenario: andere persoon verhuist in tijdens onzekerheidsperiode aanvang volgende

    Scenario: andere persoon verhuist uit tijdens onzekerheidsperiode aanvang volgende

  Rule: Als de bijhouding van de persoon tijdens de onzekerheidsperiode wordt opgeschort, ontstaat op de datum opschorting een nieuwe bewoning(samenstelling)

    Scenario: persoon overlijdt tijdens onzekerheidsperiode aanvang

    Scenario: persoon overlijdt tussen aanvang en volgende

    Scenario: persoon overlijdt tijdens onzekerheidsperiode aanvang volgende