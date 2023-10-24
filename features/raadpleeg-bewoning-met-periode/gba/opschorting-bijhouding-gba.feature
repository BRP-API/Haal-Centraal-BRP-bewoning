#language: nl

@gba
Functionaliteit: niet leveren van een bewoner met opschorting bijhouding

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |

Rule: personen met een afgevoerde persoonslijst worden niet gezien als bewoner

  Scenario: persoon heeft afgevoerde persoonslijst
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-09-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

Rule: personen op een logisch verwijderde persoonslijst worden niet gezien als bewoner

  Scenario: persoon is opgeschort met reden "W" (wissen)
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-09-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

Rule: personen met opschorting bijhouding met aanduiding ongelijk aan "F" of "W" worden na datum opschorting bijhouding niet gezien als bewoner

  Abstract Scenario: persoon is opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) en gevraagde periode eindigt op/vóór datum opschorting bijhouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2022-08-29         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2022-01-01 tot 2022-08-29 |
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

  Abstract Scenario: persoon is opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) en gevraagde periode begint vóór- en eindigt na datum opschorting bijhouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2022-01-01 tot 2022-08-29 |
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

  Abstract Scenario: persoon is opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | datum van  | scenario                                       |
    | O                            | overlijden                     | 2022-08-29 | periode begint op datum opschorting bijhouding |
    | O                            | overlijden                     | 2022-09-01 | periode begint na datum opschorting bijhouding |
    | E                            | emigratie                      | 2022-08-29 | periode begint op datum opschorting bijhouding |
    | E                            | emigratie                      | 2022-09-01 | periode begint na datum opschorting bijhouding |
    | M                            | ministerieel besluit           | 2022-08-29 | periode begint op datum opschorting bijhouding |
    | M                            | ministerieel besluit           | 2022-09-01 | periode begint na datum opschorting bijhouding |
    | R                            | pl is aangelegd in de rni      | 2022-08-29 | periode begint op datum opschorting bijhouding |
    | R                            | pl is aangelegd in de rni      | 2022-09-01 | periode begint na datum opschorting bijhouding |
    | .                            | onbekend                       | 2022-08-29 | periode begint op datum opschorting bijhouding |
    | .                            | onbekend                       | 2022-09-01 | periode begint na datum opschorting bijhouding |

  Abstract Scenario: persoon is overleden tijdens verblijf op gevraagde adres en gevraagd wordt <scenario>
    Gegeven adres 'vorige' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210314                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210526                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20211127                             | O                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2021-01-01         |
    | datumTot                         | <datumTot>         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                       |
    | periode                          | 2021-05-26 tot <periode tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001             |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | scenario                           | datumTot   | periode tot |
    | periode eindigt voor overlijden    | 2021-11-01 | 2021-11-01  |
    | periode gevraagd tot na overlijden | 2022-01-01 | 2021-11-27  |

  Scenario: persoon is overleden na vertrek uit gevraagde adres
    Gegeven adres 'vorige' heeft de volgende gegevens
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
    | 0800                              | 20210516                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210526                           |
    En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210730                           |
    En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20211014                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20211127                             | O                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2021-01-01         |
    | datumTot                         | 2022-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2021-05-26 tot 2021-07-30 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |


  Abstract Scenario: persoon bijhouding is opgeschort tijdens onzekerheidsperiode aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20211127                             | O                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode                   |
    | 20211100      | 2021-11-01 tot 2021-11-27 |
    | 20210000      | 2021-01-01 tot 2021-11-27 |
    | 00000000      | 2020-01-01 tot 2021-11-27 |

  Abstract Scenario: persoon bijhouding is opgeschort tijdens onzekerheidsperiode aanvang adreshouding en aanvang vorige ligt binnen de onzekerheidsperiode
    Gegeven adres 'vorige' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20211104                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20211127                             | O                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode                   |
    | 20211100      | 2021-11-05 tot 2021-11-27 |
    | 20210000      | 2021-11-05 tot 2021-11-27 |
    | 00000000      | 2021-11-05 tot 2021-11-27 |

  Abstract Scenario: persoon bijhouding is opgeschort tijdens onzekerheidsperiode aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20200526                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | <datum aanvang>                        | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20211127                             | R                                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde            |
    | periode                          | <periode bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001  |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode bewoner           | periode mogelijke bewoner |
    | 20211100      | 2020-05-26 tot 2021-11-01 | 2021-11-01 tot 2021-11-27 |
    | 20210000      | 2020-05-26 tot 2021-01-01 | 2021-01-01 tot 2021-11-27 |
    | 00000000      | 2020-05-26 tot 2020-05-27 | 2020-05-27 tot 2021-11-27 |
