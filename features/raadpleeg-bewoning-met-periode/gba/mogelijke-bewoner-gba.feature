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

Rule: een persoon met onbekende aanvang adreshouding, geen vorige en volgende adreshouding, is in een periode een mogelijke bewoner voor dat deel van de periode dat in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: aanvang adreshouding is deels/geheel onbekend en periode ligt in de onzekerheidsperiode van de adreshouding
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
    | datum aanvang adreshouding | datum van  | datum tot  | periode                   | opmerking                                                                                |
    | 20100800                   | 2010-08-01 | 2010-09-01 | 2010-08-01 tot 2010-09-01 | gevraagde periode overlapt de gehele onzekerheidsperiode                                 |
    | 20100800                   | 2010-08-10 | 2010-08-20 | 2010-08-10 tot 2010-08-20 | gevraagde periode overlapt een deel van de onzekerheidsperiode                           |
    | 20100000                   | 2010-01-01 | 2011-01-01 | 2010-01-01 tot 2011-01-01 | gevraagde periode overlapt de gehele onzekerheidsperiode                                 |
    | 20100000                   | 2010-12-01 | 2010-12-31 | 2010-12-01 tot 2010-12-31 | gevraagde periode overlapt een deel van de onzekerheidsperiode                           |
    | 00000000                   | 2000-01-01 | 2001-01-01 | 2000-01-01 tot 2001-01-01 | een willekeurig periode in de onzekerheidsperiode van een geheel onbekende aanvangsdatum |

  Abstract Scenario: aanvang adreshouding is deels onbekend en gevraagde periode overlapt een deel van de onzekerheidsperiode
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
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                  |
    | periode                          | <periode zeker bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001        |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum van  | datum tot  | periode mogelijke bewoner | periode zeker bewoner     |
    | 20100000                   | 2010-12-01 | 2011-12-31 | 2010-12-01 tot 2011-01-01 | 2011-01-01 tot 2011-12-31 |
    | 20100300                   | 2010-03-06 | 2010-04-18 | 2010-03-06 tot 2010-04-01 | 2010-04-01 tot 2010-04-18 |
    
  Abstract Scenario: aanvang adreshouding is deels onbekend en periode overlapt deels/geheel de onzekerheidsperiode en deels de zekerheidsperiode van de adreshouding
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
    | naam                             | waarde           |
    | periode                          | <periode 1>      |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode 2>      |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum van  | datum tot  | periode 1                 | periode 2                 |
    | 20100800                   | 2010-08-01 | 2011-01-01 | 2010-08-01 tot 2010-09-01 | 2010-09-01 tot 2011-01-01 |
    | 20100000                   | 2010-08-01 | 2012-01-01 | 2010-08-01 tot 2011-01-01 | 2011-01-01 tot 2012-01-01 |


Rule: een persoon met onbekende aanvang adreshouding, en een bekende datum volgende adreshouding die na de onzekerheidsperiode van de gevraagde adreshouding ligt, is een mogelijke bewoner voor dat deel van de periode dat binnen de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: datum aanvang volgende adreshouding ligt na de onzekerheidsperiode van deels onbekende aanvang adreshouding en periode valt helemaal in de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-08-03         |
    | datumTot                         | 2010-08-31         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-03 tot 2010-08-31 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding |
    | 20100800                   | 20101001                            |
    | 20100000                   | 20110201                            |

  Abstract Scenario: datum aanvang volgende adreshouding ligt na de onzekerheidsperiode van deels onbekende aanvang adreshouding en periode begint op/na datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2011-03-31         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  |
    | 20100800                   | 20101001                            | 2010-10-01 |
    | 20100800                   | 20101001                            | 2010-11-01 |
    | 20100000                   | 20110201                            | 2011-02-01 |
    | 20100000                   | 20110201                            | 2011-03-01 |

  Abstract Scenario: datum aanvang volgende adreshouding ligt na de onzekerheidsperiode van deels onbekende aanvang adreshouding en periode ligt tussen de onzekerheidsperiode en datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20100800                   | 20101001                            | 2010-09-01 | 2010-09-30 |
    | 20100000                   | 20110201                            | 2011-01-01 | 2011-01-31 |


Rule: een persoon met bekende aanvang volgende adreshouding die in de onzekerheidsperiode van de onbekende aanvang adreshouding ligt, is een mogelijke bewoner voor dat deel van de periode dat in de onzekerheidsperiode vóór de datum aanvang volgende adreshouding ligt 

  Abstract Scenario: datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van onbekende adreshouding en periode ligt vóór datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20100800                   | 20100821                            | 2010-08-03 | 2010-08-17 |
    | 20100800                   | 20100821                            | 2010-08-01 | 2010-08-21 |
    | 20100000                   | 20101001                            | 2010-03-14 | 2010-09-06 |
    | 20100000                   | 20101001                            | 2010-01-01 | 2010-10-01 |
    | 00000000                   | 20100101                            | 2009-12-31 | 2010-01-01 |

  Abstract Scenario: datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van onbekende adreshouding en periode begint vóór datum aanvang volgende adreshouding binnen de onzekerheidsperiode en eindigt na datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100821                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-08-03         |
    | datumTot                         | 2011-08-03         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-03 tot 2010-08-21 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding |
    | 20100800                   |
    | 20100000                   |
    | 00000000                   |

  Abstract Scenario: datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van onbekende adreshouding en periode begint binnen de onzekerheidsperiode op of na datum aanvang volgende adreshouding 
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  |
    | 20100800                   | 20100821                            | 2010-08-21 |
    | 20100800                   | 20100821                            | 2010-08-22 |
    | 20100000                   | 20101001                            | 2010-10-01 |
    | 20100000                   | 20101001                            | 2010-10-02 |
    | 00000000                   | 20100101                            | 2010-01-01 |
    | 00000000                   | 20100101                            | 2010-01-02 |

Rule: een persoon met bekende aanvang adreshouding die niet in de onzekerheidsperiode van de deels onbekende aanvang volgende adreshouding ligt, is mogelijke bewoner voor dat deel van de periode dat in de onzekerheidsperiode van het volgende adreshouding ligt

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekende aanvang volgend adreshouding en periode ligt in de onzekerheidsperiode van de volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    | datum aanvang volgende adreshouding | datum van  | datum tot  | scenario                                                                                                                     |
    | 20160500                            | 2016-05-01 | 2016-06-01 | gevraagde periode overlapt de gehele onzekerheidsperiode van volgende adreshouding (dag is onbekend)                         |
    | 20160500                            | 2016-05-06 | 2016-05-18 | gevraagde periode overlapt een deel van de onzekerheidsperiode van de volgende adreshouding (dag is onbekend)                |
    | 20160000                            | 2016-01-01 | 2016-07-01 | gevraagde periode overlapt eerste deel van de onzekerheidsperiode van de volgende adreshouding (maand en dag zijn onbekend)  |
    | 20160000                            | 2016-05-18 | 2016-05-26 | gevraagde periode overlapt een deel van de onzekerheidsperiode van de volgende adreshouding (maand en dag zijn onbekend)     |
    | 20160000                            | 2016-07-01 | 2017-01-01 | gevraagde periode overlapt laatste deel van de onzekerheidsperiode van de volgende adreshouding (maand en dag zijn onbekend) |
    | 20160000                            | 2016-12-31 | 2017-01-01 | periode begint is de laatste dag van de onzekerheidsperiode van de volgende adreshouding (maand en dag zijn onbekend)        |

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekende aanvang volgende adreshouding en periode ligt na de onzekerheidsperiode van de volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2017-05-15         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang volgende adreshouding | datum van  |
    | 20160500                            | 2016-06-01 |
    | 20160000                            | 2017-01-01 |

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekend aanvang volgende adreshouding en periode ligt vóór de onzekerheidsperiode van volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20160500                            | 2016-04-01 | 2016-05-01 |
    | 20160000                            | 2015-12-01 | 2016-01-01 |

Rule: een persoon met deels onbekende aanvang adreshouding, deels onbekende aanvang volgende adreshouding en niet-overlappende onzekerheidsperiodes, is een mogelijke bewoner voor dat deel van de periode dat in één van de onzekerheidsperiodes ligt

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang volgende adreshouding niet en <opmerking>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  | opmerking                                                                                    |
    | 20100800                   | 20101000                            | 2010-08-06 | 2010-08-21 | periode ligt in onzekerheidsperiode gevraagde adreshouding (dag is onbekend)                 |
    | 20100800                   | 20101000                            | 2010-10-04 | 2010-10-11 | periode ligt in onzekerheidsperiode volgende adreshouding (dag is onbekend)                  |
    | 20100000                   | 20110000                            | 2010-04-07 | 2010-11-30 | periode ligt in onzekerheidsperiode jaar gevraagde adreshouding (maand en dag zijn onbekend) |
    | 20100000                   | 20110000                            | 2011-10-15 | 2011-12-16 | periode ligt in onzekerheidsperiode jaar volgende adreshouding (maand en dag zijn onbekend)  |

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang volgende adreshouding niet en periode ligt na onzekerheidsperiode volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2012-08-03         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  |
    | 20100800                   | 20101000                            | 2010-11-01 |
    | 20100800                   | 20110000                            | 2012-01-01 |
    | 20100000                   | 20110200                            | 2011-03-01 |
    | 20100000                   | 20110000                            | 2012-01-01 |

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang volgende adreshouding niet en periode ligt tussen de onzekerheidsperiodes
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20100800                   | 20101000                            | 2010-09-01 | 2010-10-01 |
    | 20100800                   | 20101000                            | 2010-09-03 | 2010-09-21 |
    | 20100800                   | 20110000                            | 2010-09-01 | 2011-01-01 |
    | 20100800                   | 20110000                            | 2010-10-14 | 2010-12-15 |
    | 20100000                   | 20111000                            | 2011-03-27 | 2011-06-09 |
    | 20100000                   | 20120000                            | 2011-10-23 | 2011-11-16 |

Rule: een persoon met bekende aanvang adreshouding die in de onzekerheidsperiode van het deels/geheel onbekende volgende aanvang adreshouding ligt, is een mogelijke bewoner voor het deel van de periode dat in de onzekerheidsperiode na datum aanvang adreshouding ligt

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en periode ligt in de onzekerheidsperiode op/na datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-08-19         |
    | datumTot                         | 2010-08-23         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-19 tot 2010-08-23 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding |
    | 20100800                            |
    | 20100000                            |
    | 00000000                            |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en periode ligt in de onzekerheidsperiode tot de datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-08-03         |
    | datumTot                         | 2010-08-19         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-18 tot 2010-08-19 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding |
    | 20100800                            |
    | 20100000                            |
    | 00000000                            |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels onbekende aanvang volgende adreshouding en periode ligt na de onzekerheidperiode van volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | 2011-10-09         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang volgende adreshouding | datum van  |
    | 20100800                            | 2010-09-01 |
    | 20100000                            | 2011-01-01 |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en periode ligt in de onzekerheidsperiode vóór datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-05-16         |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang volgende adreshouding | datum tot  |
    | 20100800                            | 2010-08-03 |
    | 20100800                            | 2010-08-18 |
    | 20100000                            | 2010-08-18 |
    | 00000000                            | 2010-08-18 |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van de deels/geheel onbekende aanvang volgende adreshouding en periode begint in de onzekerheidsperiode na datum aanvang adreshouding en loopt tot na de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20080314                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-08-20         |
    | datumTot                         | 2011-08-20         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                     |
    | periode                          | 2010-08-20 tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001           |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | datum tot  |
    | 20100800                            | 2010-09-01 |
    | 20100000                            | 2011-01-01 |
    | 00000000                            | 2011-08-20 |

Rule: een persoon met onbekende aanvang adreshouding, onbekende aanvang volgende adreshouding en deels/geheel overlappende onzekerheidsperiodes, is mogelijke bewoner voor de periode tussen de eerste dag van de onzekerheidsperiode van de gevraagde adreshouding en de laatste dag van de onzekerheidsperiode van de volgende adreshouding.

  Abstract Scenario: persoon heeft onbekende aanvang adreshouding en deels/geheel overlappende onbekende aanvang volgende adreshouding en periode ligt tussen de eerste dag van de onzekerheidsperiode adreshouding en laatste dag van de onzekerheidsperiode volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
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
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  | opmerking                                                                         |
    | 20100800                   | 20100000                            | 2010-08-01 | 2010-10-12 | periode begint op de eerste dag van de onzekerheidsperiode gevraagde adreshouding |
    | 20100800                   | 20100000                            | 2010-09-11 | 2011-01-01 | periode loopt tot de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 20100000                   | 20100800                            | 2010-01-01 | 2010-05-01 | periode begint op de eerste dag van de onzekerheidsperiode gevraagde adreshouding |
    | 20100000                   | 20100800                            | 2010-04-01 | 2010-09-01 | periode loopt tot de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 00000000                   | 20100800                            | 2008-07-30 | 2010-09-01 | periode loopt tot de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 00000000                   | 20100000                            | 2008-07-30 | 2011-01-01 | periode loopt tot de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 20100800                   | 00000000                            | 2010-08-01 | 2019-09-28 | periode begint op de eerste dag van de onzekerheidsperiode gevraagde adreshouding |
    | 20100000                   | 00000000                            | 2010-01-01 | 2019-09-28 | periode begint op de eerste dag van de onzekerheidsperiode gevraagde adreshouding |

  Abstract Scenario: persoon heeft onbekende aanvang adreshouding en deels/geheel overlappend onbekende aanvang volgende adreshouding en periode loopt tot of vóór de onzekerheidsperiode gevraagde adreshouding of loopt na de onzekerheidsperiode volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
    | 20100800                   | 20100000                            | 2009-10-04 | 2010-08-01 |
    | 20100800                   | 20100000                            | 2011-01-01 | 2012-01-01 |
    | 20100000                   | 20100800                            | 2009-01-01 | 2010-01-01 |
    | 20100000                   | 20100800                            | 2010-09-01 | 2010-11-03 |
    | 00000000                   | 20100000                            | 2011-01-01 | 2011-03-19 |
    | 20100000                   | 00000000                            | 2009-11-12 | 2010-01-01 |
    | 20100800                   | 20100000                            | 2009-10-04 | 2010-07-23 |
    | 20100800                   | 20100000                            | 2011-02-18 | 2012-02-19 |
    | 20100000                   | 20100800                            | 2009-01-01 | 2009-12-25 |
    | 20100000                   | 20100800                            | 2010-10-14 | 2010-11-03 |
    | 00000000                   | 20100000                            | 2011-01-03 | 2011-03-19 |
    | 20100000                   | 00000000                            | 2009-11-12 | 2009-12-27 |

Rule: een persoon met bekende aanvang vorige adreshouding die vóór de onzekerheidsperiode van deels onbekende aanvang adreshouding ligt, is een mogelijke bewoner voor het deel van de periode dat in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: datum aanvang vorige adreshouding ligt vóór onzekerheidsperiode van deels onbekende aanvang adreshouding en periode ligt in de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000002            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100101                          | 20100800                   | 2010-08-01 | 2010-09-01 |
    | 20100101                          | 20100800                   | 2010-08-03 | 2010-08-30 |
    | 20091001                          | 20100000                   | 2010-01-01 | 2011-01-01 |
    | 20091001                          | 20100000                   | 2010-04-06 | 2010-11-30 |

  Abstract Scenario: datum aanvang vorige adreshouding ligt vóór onzekerheidsperiode van deels onbekende aanvang adreshouding en periode ligt vóór de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100101                          | 20100800                   | 2010-07-16 | 2010-08-01 |
    | 20100101                          | 20100800                   | 2010-07-16 | 2010-07-23 |
    | 20091001                          | 20100000                   | 2009-12-06 | 2010-01-01 |
    | 20091001                          | 20100000                   | 2009-10-06 | 2009-10-14 |

Rule: een persoon met bekende aanvang vorige adreshouding die in de onzekerheidsperiode van de onbekende aanvang adreshouding ligt, is een mogelijke bewoner voor het deel van de periode in de onzekerheidsperiode dat na de datum aanvang vorige adreshouding ligt

  Abstract Scenario: datum aanvang vorige adreshouding ligt in onzekerheidsperiode van onbekende aanvang adreshouding en periode ligt in de onzekerheidsperiode van gevraagde adreshouding na datum aanvang vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000002            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100810                          | 20100800                   | 2010-08-17 | 2010-08-23 |
    | 20100810                          | 20100800                   | 2010-08-11 | 2010-09-01 |
    | 20100501                          | 20100000                   | 2010-07-12 | 2010-09-30 |
    | 20100501                          | 20100000                   | 2010-05-02 | 2011-01-01 |
    | 20101014                          | 00000000                   | 2010-10-15 | 2023-09-14 |
    | 20101014                          | 00000000                   | 2022-01-01 | 2023-01-01 |

  Abstract Scenario: datum aanvang vorige adreshouding ligt in onzekerheidsperiode van onbekende aanvang adreshouding en periode ligt in de onzekerheidsperiode van gevraagde adreshouding tot of vóór datum aanvang vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100810                          | 20100800                   | 2010-08-03 | 2010-08-09 |
    | 20100810                          | 20100800                   | 2010-08-01 | 2010-08-11 |
    | 20100501                          | 20100000                   | 2010-03-17 | 2010-05-01 |
    | 20100501                          | 20100000                   | 2010-01-01 | 2010-05-02 |
    | 20101014                          | 00000000                   | 2010-04-01 | 2010-10-01 |
    | 20101014                          | 00000000                   | 2010-10-13 | 2010-10-15 |

Rule: een persoon met bekende aanvang vorige adreshouding en bekende aanvang volgende adreshouding die beide in de onzekerheidsperiode van de onbekende aanvang adreshouding ligt, is een mogelijke bewoner voor het deel van de periode dat in de onzekerheidsperiode na de datum aanvang vorige adreshouding en voor datum aanvang volgende adreshouding ligt

  Abstract Scenario: datum aanvang vorige adreshouding en datum aanvang volgende adreshouding liggen in onzekerheidsperiode van onbekende aanvang adreshouding en periode ligt in de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum aanvang volgende adreshouding | periode                   |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-11 tot 2010-08-27 |
    | 20100501                          | 20100000                   | 20101203                            | 2010-05-02 tot 2010-12-03 |
    | 20100501                          | 00000000                   | 20101203                            | 2010-05-02 tot 2010-12-03 |

  Abstract Scenario: datum aanvang vorige adreshouding en datum aanvang volgende adreshouding liggen in onzekerheidsperiode van onbekende aanvang adreshouding en periode ligt in de onzekerheidsperiode van gevraagde adreshouding <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  | scenario                                  |
    | 20100810                          | 20100800                   | 20100827                            | 2010-07-01 | 2010-08-10 | tot datum aanvang vorige adreshouding     |
    | 20100810                          | 20100800                   | 20100827                            | 2010-07-01 | 2010-08-09 | vóór datum aanvang vorige adreshouding    |
    | 20100501                          | 20100000                   | 20101203                            | 2010-04-01 | 2010-05-01 | tot datum aanvang vorige adreshouding     |
    | 20100501                          | 20100000                   | 20101203                            | 2010-04-01 | 2010-04-30 | vóór datum aanvang vorige adreshouding    |
    | 20101014                          | 00000000                   | 20160301                            | 2010-04-01 | 2010-10-14 | tot datum aanvang vorige adreshouding     |
    | 20101014                          | 00000000                   | 20160301                            | 2010-04-01 | 2010-10-13 | vóór datum aanvang vorige adreshouding    |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-27 | 2010-11-30 | vanaf datum aanvang volgende adreshouding |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-29 | 2010-11-30 | na datum aanvang volgende adreshouding    |
    | 20100501                          | 20100000                   | 20101203                            | 2010-12-03 | 2011-01-01 | vanaf datum aanvang volgende adreshouding |
    | 20100501                          | 20100000                   | 20101203                            | 2010-12-17 | 2011-01-01 | na datum aanvang volgende adreshouding    |
    | 20101014                          | 00000000                   | 20160301                            | 2016-03-01 | 2016-05-01 | vanaf datum aanvang volgende adreshouding |
    | 20101014                          | 00000000                   | 20160301                            | 2020-01-01 | 2021-01-01 | na datum aanvang volgende adreshouding    |

Rule: een persoon met deels onbekende aanvang adreshouding, deels onbekende aanvang vorige adreshouding en niet-overlappende onzekerheidsperiodes, is een mogelijke bewoner voor het deel van de periode dat in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang vorige adreshouding niet en periode ligt in de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000002            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100800                          | 20101000                   | 2010-10-01 | 2010-11-01 |
    | 20100800                          | 20110000                   | 2011-01-01 | 2012-01-01 |
    | 20100000                          | 20110200                   | 2011-02-01 | 2011-03-01 |
    | 20100000                          | 20110000                   | 2011-01-01 | 2012-01-01 |

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang vorige adreshouding niet en periode ligt vóór de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100800                          | 20101000                   | 2010-08-11 | 2010-09-12 |
    | 20100800                          | 20101000                   | 2010-08-02 | 2010-10-01 |
    | 20100800                          | 20110000                   | 2010-09-01 | 2010-12-01 |
    | 20100800                          | 20110000                   | 2010-12-31 | 2011-01-01 |
    | 20100000                          | 20110200                   | 2010-08-02 | 2011-01-19 |
    | 20100000                          | 20110200                   | 2010-08-02 | 2011-02-01 |
    | 20100000                          | 20110000                   | 2010-08-02 | 2010-12-31 |
    | 20100000                          | 20110000                   | 2010-12-31 | 2011-01-01 |
    | 20100000                          | 20110200                   | 2011-01-01 | 2011-01-19 |
    | 20100000                          | 20110200                   | 2011-01-01 | 2011-02-01 |

Rule: een persoon met onbekende aanvang adreshouding, onbekende aanvang vorige adreshouding en gelijke onzekerheidsperiode, is een mogelijke bewoner voor het deel van de periode dat in de onzekerheidsperiode ligt

  Abstract Scenario: onzekerheidsperiode van adreshouding komt overeen met onzekerheidsperiode van vorige adreshouding en periode ligt in de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000002            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 00000000                          | 00000000                   | 2010-08-31 | 2023-05-26 |
    | 20100000                          | 20100000                   | 2010-05-26 | 2010-07-30 |
    | 20100000                          | 20100000                   | 2010-01-01 | 2011-01-01 |
    | 20100500                          | 20100500                   | 2010-05-06 | 2010-05-26 |
    | 20100500                          | 20100500                   | 2010-05-01 | 2010-06-01 |

  Abstract Scenario: onzekerheidsperiode van adreshouding komt overeen met onzekerheidsperiode van vorige adreshouding en periode ligt vóór de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100000                          | 20100000                   | 2009-12-31 | 2010-01-01 |
    | 20100500                          | 20100500                   | 2010-02-01 | 2010-04-27 |
    | 20100500                          | 20100500                   | 2010-04-30 | 2010-05-01 |

Rule: een persoon met onbekende aanvang adreshouding, onbekende aanvang vorige adreshouding en deels/geheel overlappende onzekerheidsperiodes, is een mogelijke bewoner voor het deel van de periode dat in de onzekerheidsperiode van de adreshouding ligt én op of na de eerste dag van de onzekerheidsperiode van de vorige adreshouding

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding geheel en periode ligt op/na de eerste dag van de onzekerheidsperiode van vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000002            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  | opmerking                                                                                 |
    | 20100000                          | 00000000                   | 2010-01-01 | 2012-11-17 | periode begint op de eerste dag in de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100000                          | 00000000                   | 2011-01-01 | 2012-01-01 | periode begint op de eerste dag na de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100500                          | 00000000                   | 2010-05-01 | 2012-05-26 | periode begint op de eerste dag in de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100500                          | 20100000                   | 2010-05-01 | 2012-07-30 | periode begint op de eerste dag in de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100500                          | 20100000                   | 2010-06-01 | 2010-07-01 | periode begint op de eerste dag na de onzekerheidsperiode van aanvang vorige adreshouding |

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding geheel en periode ligt vóór de onzekerheidsperiode van vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 20100000                          | 00000000                   | 2009-01-01 | 2009-11-30 |
    | 20100000                          | 00000000                   | 2009-01-01 | 2010-01-01 |
    | 20100500                          | 00000000                   | 2010-01-01 | 2010-05-01 |
    | 20100500                          | 20100000                   | 2010-04-01 | 2010-05-01 |

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding deels en periode ligt in de onzekerheidsperiode van de gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000002            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 00000000                          | 20100000                   | 2010-05-26 | 2010-10-14 |
    | 00000000                          | 20100000                   | 2010-01-01 | 2011-01-01 |
    | 00000000                          | 20100500                   | 2010-05-01 | 2010-06-01 |
    | 20100000                          | 20100800                   | 2010-08-01 | 2010-09-01 |

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding deels en periode ligt vóór de onzekerheidsperiode van de gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum van  | datum tot  |
    | 00000000                          | 20100000                   | 2009-01-01 | 2010-01-01 |
    | 00000000                          | 20100500                   | 2010-03-17 | 2010-04-30 |
    | 00000000                          | 20100500                   | 2010-03-17 | 2010-05-01 |
    | 20100000                          | 20100800                   | 2010-07-30 | 2010-08-01 |

  Scenario: er wordt niet verder terug gekeken dan het verblijf vóór het gevraagde verblijf
    Gegeven adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110516                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110500                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110000                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2011-01-01         |
    | datumTot                         | 2011-05-28         |
    | adresseerbaarObjectIdentificatie | 0800010000000003   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-05-01 tot 2011-05-28 |
    | adresseerbaarObjectIdentificatie | 0800010000000003          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: een persoon met onbekende aanvang volgende adreshouding en een daaropvolgende adreshouding die binnen de onzekerheidsperiode aanvangt is mogelijke bewoner tot aanvang van de daaropvolgende adreshouding

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekende aanvang volgend adreshouding en periode ligt in de onzekerheidsperiode van de volgende adreshouding
    Gegeven adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)           |
    | 0800                              | <datum aanvang daarop volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2011-05-03         |
    | datumTot                         | 2011-05-28         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | datum aanvang daarop volgende adreshouding | periode                   | scenario                                                                         |
    | 20110500                            | 20110516                                   | 2011-05-03 tot 2011-05-16 | aanvang daaropvolgende verblijf valt binnen onzekerheidsperiode aanvang volgende |
    | 20110000                            | 20110516                                   | 2011-05-03 tot 2011-05-16 | aanvang daaropvolgende verblijf valt binnen onzekerheidsperiode aanvang volgende |
    | 00000000                            | 20110516                                   | 2011-05-03 tot 2011-05-16 | aanvang daaropvolgende verblijf valt binnen onzekerheidsperiode aanvang volgende |
    | 20110500                            | 20111014                                   | 2011-05-03 tot 2011-05-28 | aanvang daaropvolgende verblijf valt na onzekerheidsperiode aanvang volgende     |
    | 20110000                            | 20120730                                   | 2011-05-03 tot 2011-05-28 | aanvang daaropvolgende verblijf valt na onzekerheidsperiode aanvang volgende     |

  Scenario: er wordt niet verder gekeken dan één verblijf na de volgende
    Gegeven adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En adres 'A4' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000004                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110000                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110500                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20110516                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2011-05-03         |
    | datumTot                         | 2011-05-28         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2011-05-03 tot 2011-05-28 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: een persoon met onbekende aanvang adreshouding is bewoner voor dat deel van de periode dat na de onzekerheidsperiode van de gevraagde adreshouding ligt en voor de aanvang volgende verblijf

  Abstract Scenario: aanvang adreshouding is deels onbekend en er is geen volgende verblijf
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde            |
    | periode                          | <periode bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001  |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode mogelijke bewoner | periode bewoner           |
    | 20210500      | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2023-01-01 |
    | 20210000      | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 |

  Abstract Scenario: aanvang adreshouding is deels onbekend en volgende verblijfplaats na onzekerheidsperiode en binnen gevraagde periode
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20221014                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde            |
    | periode                          | <periode bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001  |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode mogelijke bewoner | periode bewoner           |
    | 20210500      | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-10-14 |
    | 20210000      | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2022-10-14 |

  Abstract Scenario: aanvang adreshouding is deels onbekend en volgende verblijfplaats na onzekerheidsperiode en na gevraagde periode
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20221014                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde            |
    | periode                          | <periode bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001  |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode mogelijke bewoner | periode bewoner           |
    | 20210500      | 2021-05-01 tot 2021-06-01 | 2021-06-01 tot 2022-10-14 |
    | 20210000      | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2022-10-14 |

  Abstract Scenario: aanvang adreshouding is deels/geheel onbekend en volgende verblijfplaats in onzekerheidsperiode en binnen gevraagde periode
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2022-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode mogelijke bewoner |
    | 20210500      | 2021-05-01 tot 2021-05-26 |
    | 20210000      | 2021-01-01 tot 2021-05-26 |
    | 00000000      | 2020-01-01 tot 2021-05-26 |

  Abstract Scenario: aanvang adreshouding is deels/geheel onbekend en volgende verblijfplaats in onzekerheidsperiode en na gevraagde periode
    Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang>                    |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2021-05-16         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <periode mogelijke bewoner> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |

    Voorbeelden:
    | datum aanvang | periode mogelijke bewoner |
    | 20210500      | 2021-05-01 tot 2021-05-16 |
    | 20210000      | 2021-01-01 tot 2021-05-16 |
    | 00000000      | 2020-01-01 tot 2021-05-16 |
