#language: nl

@gba
Functionaliteit: raadpleeg bewoning in periode

  Als consumer van de Bewoning API
  wil ik kunnen opvragen welke personen in een periode op een adresseerbaar object verblijven/hebben verbleven
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |
    En adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |

Rule: Een persoon dat verblijft op de gevraagde adresseerbaar object met een bekende datum aanvang adreshouding is bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de adreshoudingperiode ligt

  Abstract Scenario: <scenario> (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2011-09-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  | periode                   | scenario                                                  |
    | 2010-09-01 | 2010-09-01 tot 2011-09-01 | De gevraagde periode ligt in de adreshoudingperiode       |
    | 2010-08-01 | 2010-08-18 tot 2011-09-01 | De gevraagde periode ligt deels in de adreshoudingperiode |
    # 24 |--A1--     |--A1--
    #     |----|   |---|
    # res |----|     |-|

  Abstract Scenario: persoon heeft het gevraagde adresseerbaar object als briefadres opgegeven en <scenario> (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2011-09-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum van  | periode                   | scenario                                                  |
    | 2010-09-01 | 2010-09-01 tot 2011-09-01 | de gevraagde periode ligt in de adreshoudingperiode       |
    | 2010-08-01 | 2010-08-18 tot 2011-09-01 | de gevraagde periode ligt deels in de adreshoudingperiode |

  Abstract Scenario: <scenario> (wel vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2017-06-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  | periode                   | scenario                                                                                            |
    | 2016-06-01 | 2016-06-01 tot 2017-06-01 | De gevraagde periode ligt in de adreshoudingperiode                                                 |
    | 2010-05-01 | 2016-05-26 tot 2017-06-01 | Datum aanvang adreshouding en datum aanvang vorige adreshouding ligt in de gevraagde periode        |
    | 2011-12-01 | 2016-05-26 tot 2017-06-01 | De gevraagde periode ligt deels in de vorige adreshoudingperiode en deels in de adreshoudingperiode |
    # 24 |--A1--|--A2--    |--A1--|--A2--   |--A1--|--A2--
    #            |--|     |-----------           |---|
    # res        |--|             |---|            |-|

  Abstract Scenario: <scenario> (geen vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  | datum tot  | periode                   | scenario                                                                                              |
    | 2016-01-01 | 2016-05-01 | 2016-01-01 tot 2016-05-01 | De gevraagde periode ligt in de adreshoudingperiode                                                   |
    | 2010-01-01 | 2017-01-01 | 2010-08-18 tot 2016-05-26 | Datum aanvang adreshouding en datum aanvang volgende adreshouding ligt in de gevraagde periode        |
    | 2016-02-02 | 2017-01-01 | 2016-02-02 tot 2016-05-26 | De gevraagde periode ligt deels in de adreshoudingperiode en deels in de volgende adreshoudingperiode |
    # 24 |--A1--|--A2--    |--A1--|--A2--   |--A1--|--A2--
    #     |---|           |----------|           |---|
    # res |---|            |------|              |-|

  Abstract Scenario: <scenario> (wel vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  | datum tot  | periode                   | scenario                                                                                                                            |
    | 2016-06-01 | 2020-10-01 | 2016-06-01 tot 2020-10-01 | De gevraagde periode ligt in de adreshoudingperiode                                                                                 |
    | 2010-01-01 | 2021-01-01 | 2016-05-26 tot 2020-10-08 | Datum aanvang vorige adreshouding, datum aanvang volgende adreshouding en datum aanvang adreshouding liggen in de gevraagde periode |
    # 24 |--A1--|--A2--|--A3--   |--A1--|--A2--|--A3--
    #             |---|         |----------------|
    # res         |---|                 |------|

  Abstract Scenario: De gevraagde periode ligt geheel vóór of na de adreshoudingperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeriode                   |
    | datumVan                         | <van>                                |
    | datumTot                         | <tot>                                |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | van        | tot        | adresseerbaar object identificatie |
    | 2010-01-01 | 2010-08-18 | 0800010000000001                   |
    | 2016-05-26 | 2017-01-01 | 0800010000000001                   |
    | 2016-01-01 | 2016-05-26 | 0800010000000002                   |
    | 2020-10-08 | 2021-01-21 | 0800010000000002                   |
    | 2020-01-01 | 2020-10-08 | 0800010000000003                   |
    # 24      |--A1--|--A2--|--A3--   |--A1--|--A2--|--A3--    |--A1--|--A2--|--A3--    |--A1--|--A2--|--A3--
    #     |---|                          (A1)|---|            (A2)|---|                           (A2)|---|
    # res

Rule: Voor een periode worden meerdere bewoningen geleverd als de samenstelling van bewoners in de periode is veranderd

  Scenario: De gevraagde periode ligt in de adreshoudingperiode van één persoon en ligt deels in de adreshoudingperiode van een ander persoon
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20140808                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2015-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-01-01 tot 2014-08-08 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-08-08 tot 2015-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

Rule: Voor een (deel van de) periode wordt geen bewoning geleverd als er binnen (dat deel van) de periode geen personen verblijven/hebben verbleven op het adresseerbaar object

  Scenario: De gevraagde periode overlapt een periode waarbinnen het adresseerbaar object tijdelijk niet was bewoond
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20140707                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20140808                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2015-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-01-01 tot 2014-07-07 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-08-08 tot 2015-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000048           |

Rule: Een persoon met een afgevoerde persoonslijst of logisch verwijderde persoonslijst wordt niet gezien als bewoner

  Scenario: persoon met adreshouding op het gevraagde adresseerbaar object heeft een afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

  Scenario: persoon met adreshouding op het gevraagde adresseerbaar object is opgeschort met reden "W" (wissen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

Rule: Een persoon met opschorting bijhouding wordt na datum opschorting bijhouding niet gezien als bewoner

  Abstract Scenario: persoon met adreshouding op het gevraagde adresseerbaar object is opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) en datum opschorting ligt in de adreshoudingperiode (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-18 tot 2022-08-29 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | R                            | pl is aangelegd in de rni      |
    | .                            | onbekend                       |

  Abstract Scenario: persoon met adreshouding op het gevraagde adresseerbaar object is opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) en datum opschorting ligt in de adreshoudingperiode (wel vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20050414                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-18 tot 2022-08-29 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving |
    | O                            | overlijden                     |
    | E                            | emigratie                      |
    | M                            | ministerieel besluit           |
    | R                            | pl is aangelegd in de rni      |
    | .                            | onbekend                       |

Rule: Een persoon met geheel/deels onbekende datum aanvang adreshouding is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiode van de adreshouding ligt

  De adreshouding van een persoon heeft een onzekerheidsperiode als de datum aanvang adreshouding geheel/deels onbekend is.
  In deze periode kan niet met zekerheid worden aangegeven of de persoon daadwerkelijk bewoner is van het adresseerbaar object.
  Voor een datum aanvang adreshouding waarvan de dag onbekend is, loopt de onzekerheidsperiode vanaf de eerste dag tot en met de laatste dag van de betreffende maand.
  Voor een datum aanvang adreshouding waarvan de dag en maand onbekend is, loopt de onzekerheidsperiode vanaf de eerste dag tot en met de laatste dag van het betreffende jaar.

  Abstract Scenario: De gevraagde periode ligt geheel in de onzekerheidsperiode van de adreshoudingperiode (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100800                   | 2010-08-01 | 2010-09-01 |
    | 20100800                   | 2010-08-14 | 2010-09-01 |
    | 20101200                   | 2010-12-05 | 2011-01-01 |

  Scenario: De gevraagde periode overlapt de onzekerheidsperiode van de adreshoudingperiode (geen vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-07-01         |
    | datumTot                         | 2010-10-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-01 tot 2010-09-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-09-01 tot 2010-10-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: De gevraagde periode ligt geheel in de onzekerheidsperiode van de adreshoudingperiode (wel vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2017-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                     |
    | periode                          | <datum van> tot 2017-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002           |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  |
    | 2016-01-01 |
    | 2016-06-15 |

  Scenario: De gevraagde periode overlapt de onzekerheidsperiode van de adreshoudingperiode (wel vorige en geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2015-01-01         |
    | datumTot                         | 2018-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2016-01-01 tot 2017-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2017-01-01 tot 2018-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: De gevraagde periode ligt geheel in de onzekerheidsperiode van de adreshoudingperiode (geen vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2010-09-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                     |
    | periode                          | <datum van> tot 2010-09-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001           |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  |
    | 2010-08-01 |
    | 2010-08-10 |

  Scenario: De gevraagde periode overlapt de onzekerheidsperiode van de adreshoudingperiode (geen vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-01 tot 2010-09-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-09-01 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: De gevraagde periode ligt geheel in de onzekerheidsperiode van de adreshoudingperiode (wel vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2017-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                     |
    | periode                          | <datum van> tot 2017-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002           |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  |
    | 2016-01-01 |
    | 2016-06-06 |

  Abstract Scenario: De gevraagde periode overlapt de onzekerheidsperiode van de adreshoudingperiode (wel vorige en wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2021-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2016-01-01 tot 2017-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2017-01-01 tot 2020-10-08 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met geheel/deels onbekende datum aanvang adreshouding en bekende datum aanvang vorige adreshouding, is een mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiode van de adreshouding na datum aanvang vorige adreshouding ligt

  Scenario: Datum aanvang vorige adreshouding ligt niet in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090712                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-01-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang vorige adreshouding ligt niet in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20091216                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20120101                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-01-01         |
    | datumTot                         | 2013-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang vorige adreshouding ligt in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-15 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang vorige adreshouding ligt in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20120101                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2013-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-15 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met geheel/deels onbekend datum aanvang adreshouding en bekende datum aanvang volgende adreshouding, is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiode van de adreshouding vóór datum aanvang volgende adreshouding ligt

  Scenario: Datum aanvang volgende adreshouding ligt niet in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (geen vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110814                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-08-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2011-08-14 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang volgende adreshouding ligt niet in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (wel vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090101                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110814                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-08-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2011-08-14 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (geen vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-08-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2010-08-14 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (wel vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090101                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-08-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2010-08-14 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met geheel/deels onbekende datum aanvang adreshouding, bekende datum aanvang vorige adreshouding en bekende datum aanvang volgende adreshouding, is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiode van de adreshouding tussen datum vorige adreshouding en datum volgende adreshouding ligt

  Scenario: Datum aanvang vorige en volgende adreshouding liggen niet in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-08-01         |
    | datumTot                         | 2021-06-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2012-01-01 tot 2020-10-08 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang vorige en volgende adreshouding liggen in de onzekerheidsperiode van de adreshouding en de gevraagde periode overlapt de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20201008                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-08-01         |
    | datumTot                         | 2021-06-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-15 tot 2020-10-08 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met bekende datum aanvang adreshouding en geheel/deels onbekende datum aanvang volgende adreshouding, is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiode van de volgende adreshouding na datum aanvang adreshouding ligt

  Scenario: Datum aanvang adreshouding ligt niet in de onzekerheidsperiode van de volgende adreshouding en gevraagde periode overlapt de onzekerheidsperiode (geen vorige adreshouding)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-06-01         |
    | datumTot                         | 2012-07-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-14 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: Datum aanvang adreshouding ligt niet in de onzekerheidsperiode van de volgende adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (wel vorige adreshouding)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100101                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-05-01         |
    | datumTot                         | 2012-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-14 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-01-01 tot 2012-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: Datum aanvang adreshouding ligt in de onzekerheidsperiode van de volgende adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (geen vorige adreshouding)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-03-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-14 tot 2010-08-15 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <mogelijke bewoner periode> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | mogelijke bewoner periode |
    | 20100800                            | 2010-08-15 tot 2010-09-01 |
    | 20100000                            | 2010-08-15 tot 2011-01-01 |
    | 00000000                            | 2010-08-15 tot 2012-01-01 |

  Abstract Scenario: Datum aanvang adreshouding ligt in de onzekerheidsperiode van de volgende adreshouding en de gevraagde periode overlapt de onzekerheidsperiode (wel vorige adreshouding)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090101                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2012-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-14 tot 2010-08-15 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <mogelijke bewoner periode> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | mogelijke bewoner periode |
    | 20100800                            | 2010-08-15 tot 2010-09-01 |
    | 20100000                            | 2010-08-15 tot 2011-01-01 |
    | 00000000                            | 2010-08-15 tot 2012-01-01 |

Rule: Een persoon met geheel/deels onbekende datum aanvang adreshouding, geheel/deels onbekende datum aanvang volgende adreshouding en optioneel een bekende datum aanvang vorige adreshouding die niet in de onzekerheidsperiode ligt, is een mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in één van de onzekerheidsperiodes ligt

  Scenario: De gevraagde periode overlapt de niet-overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang volgende adreshouding (geen vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-01 tot 2010-09-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-09-01 tot 2010-11-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-11-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: De gevraagde periode overlapt de niet-overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang volgende adreshouding (wel datum aanvang vorige adreshouding die niet in de onzekerheidsperiodes ligt)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090501                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-01 tot 2010-09-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-09-01 tot 2010-11-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-11-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: De gevraagde periode overlapt de deels overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang volgende adreshouding (geen vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: De gevraagde periode overlapt de deels overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang volgende adreshouding (wel datum aanvang vorige adreshouding die niet in de onzekerheidsperiodes ligt)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090501                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-01-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: De gevraagde periode overlapt de geheel overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en de deels onbekende datum aanvang volgende adreshouding (geen vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20100000                   | 20100000                            | 2010-01-01 | 2011-01-01 |
    | 20090800                   | 20090800                            | 2009-08-01 | 2009-09-01 |

  Abstract Scenario: De gevraagde periode overlapt de geheel overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en de deels onbekende datum aanvang volgende adreshouding (wel datum aanvang vorige adreshouding die niet in de onzekerheidsperiodes ligt)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090501                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20100000                   | 20100000                            | 2010-01-01 | 2011-01-01 |
    | 20090800                   | 20090800                            | 2009-08-01 | 2009-09-01 |

  Scenario: De gevraagde periode ligt in de geheel overlappende onzekerheidsperiodes van de geheel onbekende datum aanvang adreshouding en geheel onbekende datum aanvang volgende adreshouding (geen vorige adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2009-07-01 tot 2011-02-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met geheel/deels onbekende datum aanvang adreshouding, geheel/deels onbekende datum aanvang volgende adreshouding en een bekende datum aanvang vorige adreshouding die in de onzekerheidsperiode ligt, is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in één van de onzekerheidsperiodes ná datum aanvang vorige adreshouding ligt 

  Scenario: De gevraagde periode overlapt de niet-overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang volgende adreshouding en datum aanvang vorige adreshouding ligt in de onzekerheidsperiode van de adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100814                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-15 tot 2010-09-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-09-01 tot 2010-11-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-11-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: De gevraagde periode overlapt de deels overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang volgende adreshouding en de datum aanvang vorige adreshouding ligt in de onzekerheidsperiode van de adreshouding en vóór de onzekerheidsperiode van de volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100208                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-02-09 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: De gevraagde periode overlapt de geheel overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding én de deels onbekende datum aanvang volgende adreshouding én de datum aanvang vorige adreshouding die in de onzekerheidsperiodes ligt
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090510                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2008-01-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20090000                   | 20090000                            | 2009-05-11 | 2010-01-01 |
    | 20090500                   | 20090500                            | 2009-05-11 | 2009-06-01 |

  Scenario: De gevraagde periode overlapt de geheel overlappende onzekerheidsperiodes van de geheel onbekende datum aanvang adreshouding én de geheel onbekende datum aanvang volgende adreshouding én de datum aanvang vorige adreshouding die in de onzekerheidsperiodes ligt
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20090510                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2008-01-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2009-05-11 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met deels onbekend datum aanvang adreshouding, deels onbekend datum aanvang vorige adreshouding waarvan de onzekerheidsperiodes niet overlappen, is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiode van de adreshouding ligt

  # A1    |~~-|
  # A2        |~~---
  #     |----------|
  # res       |~~--|
  Scenario: De gevraagde periode overlapt de niet-overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang vorige adreshouding (geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-11-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-12-01 tot 2011-02-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  # A1    |~~-|
  # A2        |~~--
  # A3            |----
  #     |---------|
  # res       |~~-|
  Scenario: De gevraagde periode overlapt de niet-overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang vorige adreshouding (wel datum aanvang volgende adreshouding die niet in de onzekerheidsperiode van de adreshouding ligt)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20101100                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110101                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-11-01 tot 2010-12-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-12-01 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: Een persoon met geheel/deels onbekend datum aanvang adreshouding, geheel/deels onbekend datum aanvang vorige adreshouding waarvan de onzekerheidsperiodes geheel/deels overlappen, is mogelijke bewoner in (een deel van) de gevraagde periode als (dat deel van) de gevraagde periode in de onzekerheidsperiodes ligt

  Abstract Scenario: De gevraagde periode overlapt de deels overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang vorige adreshouding (geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 1>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 2>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | periode 1                 | periode 2                 |
    | 20100000                          | 20101100                   | 2010-11-01 tot 2010-12-01 | 2010-12-01 tot 2011-02-01 |
    | 20101100                          | 20100000                   | 2010-11-01 tot 2011-01-01 | 2011-01-01 tot 2011-02-01 |

  Abstract Scenario: De gevraagde periode overlapt de deels overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang vorige adreshouding (wel datum aanvang volgende adreshouding die niet in de onzekerheidsperiode van de adreshouding ligt)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20111215                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 1>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 2>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | periode 1                 | periode 2                 |
    | 20100000                          | 20101100                   | 2010-11-01 tot 2010-12-01 | 2010-12-01 tot 2011-02-01 |
    | 20101100                          | 20100000                   | 2010-11-01 tot 2011-01-01 | 2011-01-01 tot 2011-02-01 |

  Abstract Scenario: De gevraagde periode overlapt de geheel overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang vorige adreshouding (geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 1>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 2>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | periode 1                 | periode 2                 |
    | 20100800                          | 20100800                   | 2010-08-01 tot 2010-09-01 | 2010-09-01 tot 2011-02-01 |
    | 20100000                          | 20100000                   | 2010-01-01 tot 2011-01-01 | 2011-01-01 tot 2011-02-01 |

  Abstract Scenario: De gevraagde periode overlapt de geheel overlappende onzekerheidsperiodes van de deels onbekende datum aanvang adreshouding en deels onbekende datum aanvang vorige adreshouding (wel datum aanvang volgende adreshouding die niet in de onzekerheidsperiode van de adreshouding ligt)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110114                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 1>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 2>      |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | periode 1                 | periode 2                 |
    | 20100800                          | 20100800                   | 2010-08-01 tot 2010-09-01 | 2010-09-01 tot 2011-01-14 |
    | 20100000                          | 20100000                   | 2010-01-01 tot 2011-01-01 | 2011-01-01 tot 2011-01-14 |

  Scenario: De gevraagde periode ligt in de onzekerheidsperiode van de geheel onbekende datum aanvang adreshouding en geheel onbekende datum aanvang vorige adreshouding (geen volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2009-07-01 tot 2011-02-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: De gevraagde periode ligt in de onzekerheidsperiode van de geheel onbekende datum aanvang adreshouding en geheel onbekende datum aanvang vorige adreshouding (wel volgende adreshoudingperiode)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 00000000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110102                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2009-07-01         |
    | datumTot                         | 2011-02-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2009-07-01 tot 2011-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
