#language: nl

@gba
Functionaliteit: raadpleeg bewoning op peildatum bij geheel/deels onbekende datum aanvang adreshouding

  Als consumer van de Bewoning API
  wil ik kunnen opvragen welke personen op een datum op een adresseerbaar object mogelijk verblijven/hebben verbleven
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |

Rule: een persoon die verblijft op het gevraagde adresseerbaar object met onbekende aanvang adreshouding, geen vorige en volgende adreshouding, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: aanvang adreshouding is onbekend en peildatum ligt in de onzekerheidsperiode van de adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | peildatum  | periode                   | opmerking                                     |
    | 20100800                   | 2010-08-01 | 2010-08-01 tot 2010-08-02 | eerste dag in onbekende dag datum             |
    | 20100800                   | 2010-08-31 | 2010-08-31 tot 2010-09-01 | laatste dag in onbekende dag datum            |
    | 20100000                   | 2010-01-01 | 2010-01-01 tot 2010-01-02 | eerste dag in onbekende dag en maand datum    |
    | 20100000                   | 2010-12-31 | 2010-12-31 tot 2011-01-01 | laatste dag in onbekende dag en maand datum   |
    | 00000000                   | 2000-01-01 | 2000-01-01 tot 2000-01-02 | een willekeurig dag in geheel onbekende datum |

  Abstract Scenario: persoon heeft het gevraagde adresseerbaar object als briefadres opgegeven en aanvang adreshouding is onbekend en peildatum ligt in de onzekerheidsperiode van de adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | peildatum  | periode                   | opmerking                                     |
    | 20100800                   | 2010-08-01 | 2010-08-01 tot 2010-08-02 | eerste dag in onbekende dag datum             |
    | 20100800                   | 2010-08-31 | 2010-08-31 tot 2010-09-01 | laatste dag in onbekende dag datum            |
    | 20100000                   | 2010-01-01 | 2010-01-01 tot 2010-01-02 | eerste dag in onbekende dag en maand datum    |
    | 20100000                   | 2010-12-31 | 2010-12-31 tot 2011-01-01 | laatste dag in onbekende dag en maand datum   |
    | 00000000                   | 2000-01-01 | 2000-01-01 tot 2000-01-02 | een willekeurig dag in geheel onbekende datum |

  Abstract Scenario: aanvang adreshouding is deels onbekend en peildatum ligt vóór de onzekerheidsperiode van de adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | peildatum  |
    | 20100800                   | 2010-07-31 |
    | 20100000                   | 2009-12-31 |

  Abstract Scenario: aanvang adreshouding is deels onbekend en peildatum ligt na onzekerheidsperiode adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | peildatum  | periode                   |
    | 20100800                   | 2010-09-01 | 2010-09-01 tot 2010-09-02 |
    | 20100000                   | 2011-01-01 | 2011-01-01 tot 2011-01-02 |

Rule: een persoon met onbekende aanvang adreshouding, en een bekende datum volgende adreshouding die na de onzekerheidsperiode van de gevraagde adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: datum aanvang volgende adreshouding ligt na de onzekerheidsperiode van deels onbekende aanvang adreshouding en peildatum ligt in de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   |
    | 20100800                   | 20101001                            | 2010-08-31 | 2010-08-31 tot 2010-09-01 |
    | 20100000                   | 20110201                            | 2010-12-31 | 2010-12-31 tot 2011-01-01 |

  Abstract Scenario: datum aanvang volgende adreshouding ligt na de onzekerheidsperiode van deels onbekende aanvang adreshouding en peildatum ligt op/na datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  |
    | 20100800                   | 20101001                            | 2010-10-01 |
    | 20100000                   | 20110201                            | 2011-02-01 |

  Abstract Scenario: datum aanvang volgende adreshouding ligt na de onzekerheidsperiode van deels onbekende aanvang adreshouding en peildatum ligt tussen de onzekerheidsperiode en datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   |
    | 20100800                   | 20101001                            | 2010-09-01 | 2010-09-01 tot 2010-09-02 |
    | 20100000                   | 20110201                            | 2011-01-01 | 2011-01-01 tot 2011-01-02 |

Rule: een persoon met bekende aanvang volgende adreshouding die in de onzekerheidsperiode van de onbekende aanvang adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode vóór de datum aanvang volgend adreshouding ligt 

  Abstract Scenario: datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van onbekende adreshouding en peildatum ligt vóór datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   |
    | 20100800                   | 20100821                            | 2010-08-20 | 2010-08-20 tot 2010-08-21 |
    | 20100000                   | 20101001                            | 2010-09-30 | 2010-09-30 tot 2010-10-01 |
    | 00000000                   | 20100101                            | 2009-12-31 | 2009-12-31 tot 2010-01-01 |

  Abstract Scenario: datum aanvang volgende adreshouding ligt in de onzekerheidsperiode van onbekende adreshouding en peildatum ligt op/na datum aanvang volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  |
    | 20100800                   | 20100821                            | 2010-08-21 |
    | 20100800                   | 20100821                            | 2010-08-22 |
    | 20100000                   | 20101001                            | 2010-10-01 |
    | 20100000                   | 20101001                            | 2010-10-02 |
    | 00000000                   | 20100101                            | 2010-01-01 |
    | 00000000                   | 20100101                            | 2010-01-02 |
    | 00000000                   | 20100101                            | 2011-05-26 |

Rule: een persoon met bekende aanvang adreshouding die niet in de onzekerheidsperiode van de deels onbekende aanvang volgende adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode van het volgende adreshouding ligt

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekende aanvang volgend adreshouding en peildatum ligt in de onzekerheidsperiode van de volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | peildatum  | periode                   | scenario                                                               |
    | 20160500                            | 2016-05-01 | 2016-05-01 tot 2016-05-02 | peildatum is de eerste dag van de volgende aanvang adreshouding maand  |
    | 20160500                            | 2016-05-18 | 2016-05-18 tot 2016-05-19 | peildatum is een dag binnen de volgende aanvang adreshouding maand     |
    | 20160500                            | 2016-05-31 | 2016-05-31 tot 2016-06-01 | peildatum is de laatste dag van de volgende aanvang adreshouding maand |
    | 20160000                            | 2016-01-01 | 2016-01-01 tot 2016-01-02 | peildatum is de eerste dag van het volgende aanvang adreshouding jaar  |
    | 20160000                            | 2016-05-18 | 2016-05-18 tot 2016-05-19 | peildatum is een dag binnen het volgende aanvang adreshouding jaar     |
    | 20160000                            | 2016-12-31 | 2016-12-31 tot 2017-01-01 | peildatum is de laatste dag van het volgende aanvang adreshouding jaar |

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekende aanvang volgende adreshouding en peildatum ligt na de onzekerheidsperiode van de volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang volgende adreshouding | peildatum  |
    | 20160500                            | 2016-06-01 |
    | 20160000                            | 2017-01-01 |

  Abstract Scenario: datum aanvang adreshouding ligt niet in de onzekerheidsperiode van het deels onbekend aanvang volgende adreshouding en peildatum ligt vóór de onzekerheidsperiode van volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding | peildatum  | periode                   |
    | 20160500                            | 2016-04-30 | 2016-04-30 tot 2016-05-01 |
    | 20160000                            | 2015-12-31 | 2015-12-31 tot 2016-01-01 |

Rule: een persoon met deels onbekende aanvang adreshouding, deels onbekende aanvang volgende adreshouding en niet-overlappende onzekerheidsperiodes, is op peildatum een mogelijke bewoner als de peildatum in één van de onzekerheidsperiodes ligt

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang volgende adreshouding niet en peildatum ligt in één van de onzekerheidsperiodes
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   | opmerking                                                    |
    | 20100800                   | 20101000                            | 2010-08-20 | 2010-08-20 tot 2010-08-21 | peildatum ligt in onzekerheidsperiode gevraagde adreshouding |
    | 20100800                   | 20101000                            | 2010-10-10 | 2010-10-10 tot 2010-10-11 | peildatum ligt in onzekerheidsperiode volgende adreshouding  |
    | 20100000                   | 20111000                            | 2010-09-30 | 2010-09-30 tot 2010-10-01 | peildatum ligt in onzekerheidsperiode gevraagde adreshouding |
    | 20100000                   | 20111000                            | 2011-10-15 | 2011-10-15 tot 2011-10-16 | peildatum ligt in onzekerheidsperiode volgende adreshouding  |

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang volgende adreshouding niet en peildatum ligt na onzekerheidsperiode volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  |
    | 20100800                   | 20101000                            | 2010-11-01 |
    | 20100800                   | 20110000                            | 2012-01-01 |
    | 20100000                   | 20110200                            | 2011-03-01 |
    | 20100000                   | 20110000                            | 2012-01-01 |

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang volgende adreshouding niet en peildatum ligt tussen de onzekerheidsperiodes
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   |
    | 20100800                   | 20101000                            | 2010-09-01 | 2010-09-01 tot 2010-09-02 |
    | 20100800                   | 20110000                            | 2010-12-31 | 2010-12-31 tot 2011-01-01 |
    | 20100000                   | 20111000                            | 2011-01-30 | 2011-01-30 tot 2011-01-31 |
    | 20100000                   | 20120000                            | 2011-10-15 | 2011-10-15 tot 2011-10-16 |

Rule: een persoon met bekende aanvang adreshouding die in de onzekerheidsperiode van het deels/geheel onbekende volgende aanvang adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode na datum aanvang adreshouding ligt

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en peildatum ligt in de onzekerheidsperiode op/na datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-19           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-19 tot 2010-08-20 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding |
    | 20100800                            |
    | 20100000                            |
    | 00000000                            |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en peildatum ligt in de onzekerheidsperiode na datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20080413                           |
    En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-19           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-19 tot 2010-08-20 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang volgende adreshouding |
    | 20100800                            |
    | 20100000                            |
    | 00000000                            |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en peildatum ligt in de onzekerheidsperiode op datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
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

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels onbekende aanvang volgende adreshouding en peildatum ligt na de onzekerheidperiode van volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang volgende adreshouding | peildatum  |
    | 20100800                            | 2010-09-01 |
    | 20100000                            | 2011-01-01 |

  Abstract Scenario: datum aanvang adreshouding ligt in de onzekerheidsperiode van het deels/geheel onbekende aanvang volgende adreshouding en peildatum ligt in de onzekerheidsperiode vóór datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-17           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang volgende adreshouding |
    | 20100800                            |
    | 20100000                            |
    | 00000000                            |

Rule: een persoon met onbekende aanvang adreshouding, onbekende aanvang volgende adreshouding en deels/geheel overlappende onzekerheidsperiodes, is op peildatum een mogelijke bewoner als de peildatum tussen de eerste dag van de onzekerheidsperiode van de gevraagde adreshouding en de laatste dag van de onzekerheidsperiode van de volgende adreshouding.

  Abstract Scenario: persoon heeft onbekende aanvang adreshouding en deels/geheel overlappende onbekende aanvang volgende adreshouding en peildatum ligt tussen de eerste dag van de onzekerheidsperiode adreshouding en laatste dag van de onzekerheidsperiode volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   | opmerking                                                                    |
    | 20100800                   | 20100000                            | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum is de eerste dag van de onzekerheidsperiode gevraagde adreshouding |
    | 20100800                   | 20100000                            | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum is de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 20100000                   | 20100800                            | 2010-01-01 | 2010-01-01 tot 2010-01-02 | peildatum is de eerste dag van de onzekerheidsperiode gevraagde adreshouding |
    | 20100000                   | 20100800                            | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum is de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 00000000                   | 20100800                            | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum is de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 00000000                   | 20100000                            | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum is de laatste dag van de onzekerheidsperiode volgende adreshouding |
    | 20100800                   | 00000000                            | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum is de eerste dag van de onzekerheidsperiode gevraagde adreshouding |
    | 20100000                   | 00000000                            | 2010-01-01 | 2010-01-01 tot 2010-01-02 | peildatum is de eerste dag van de onzekerheidsperiode gevraagde adreshouding |

  Abstract Scenario: persoon heeft onbekende aanvang adreshouding en deels/geheel overlappend onbekende aanvang volgende adreshouding en peildatum ligt of vóór de onzekerheidsperiode gevraagde adreshouding of na de onzekerheidsperiode volgende adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
    | 0800                              | <datum aanvang volgende adreshouding> |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  |
    | 20100800                   | 20100000                            | 2010-07-31 |
    | 20100800                   | 20100000                            | 2011-01-01 |
    | 20100000                   | 20100800                            | 2009-12-31 |
    | 20100000                   | 20100800                            | 2010-09-01 |
    | 00000000                   | 20100000                            | 2011-01-01 |
    | 20100000                   | 00000000                            | 2009-12-31 |

Rule: een persoon met bekende aanvang vorige adreshouding die vóór de onzekerheidsperiode van deels onbekende aanvang adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: datum aanvang vorige adreshouding ligt vóór onzekerheidsperiode van deels onbekende aanvang adreshouding en peildatum ligt in de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   |
    | 20100101                          | 20100800                   | 2010-08-01 | 2010-08-01 tot 2010-08-02 |
    | 20091001                          | 20100000                   | 2010-01-01 | 2010-01-01 tot 2010-01-02 |

  Abstract Scenario: datum aanvang vorige adreshouding ligt vóór onzekerheidsperiode van deels onbekende aanvang adreshouding en peildatum ligt vóór de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   |
    | 20100101                          | 20100800                   | 2010-07-31 | 2010-07-31 tot 2010-08-01 |
    | 20091001                          | 20100000                   | 2009-12-31 | 2009-12-31 tot 2010-01-01 |

Rule: een persoon met bekend aanvang vorige adreshouding die in de onzekerheidsperiode van de onbekende aanvang adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode na de datum aanvang vorige adreshouding ligt

  Abstract Scenario: datum aanvang vorige adreshouding ligt in onzekerheidsperiode van onbekende aanvang adreshouding en peildatum ligt in de onzekerheidsperiode van gevraagde adreshouding na datum aanvang vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   |
    | 20100810                          | 20100800                   | 2010-08-11 | 2010-08-11 tot 2010-08-12 |
    | 20100501                          | 20100000                   | 2010-05-02 | 2010-05-02 tot 2010-05-03 |
    | 20101014                          | 00000000                   | 2010-10-15 | 2010-10-15 tot 2010-10-16 |

  Abstract Scenario: datum aanvang vorige adreshouding ligt in onzekerheidsperiode van onbekende aanvang adreshouding en peildatum ligt in de onzekerheidsperiode van gevraagde adreshouding op of vóór datum aanvang vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  |
    | 20100810                          | 20100800                   | 2010-08-10 |
    | 20100810                          | 20100800                   | 2010-08-09 |
    | 20100501                          | 20100000                   | 2010-05-01 |
    | 20100501                          | 20100000                   | 2010-04-30 |
    | 20101014                          | 00000000                   | 2010-10-14 |
    | 20101014                          | 00000000                   | 2010-10-13 |

Rule: een persoon met bekend aanvang vorige adreshouding en bekende aanvang volgende adreshouding die beide in de onzekerheidsperiode van de onbekende aanvang adreshouding ligt, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode na de datum aanvang vorige adreshouding en voor datum aanvang volgende adreshouding ligt

  Abstract Scenario: datum aanvang vorige adreshouding en datum aanvang volgende adreshouding liggen in onzekerheidsperiode van onbekende aanvang adreshouding en peildatum ligt in de onzekerheidsperiode van gevraagde adreshouding na datum aanvang vorige adreshouding en voor aanvang volgende adreshouding
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
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | periode                   |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-11 | 2010-08-11 tot 2010-08-12 |
    | 20100501                          | 20100000                   | 20101203                            | 2010-05-02 | 2010-05-02 tot 2010-05-03 |
    | 20100501                          | 00000000                   | 20160301                            | 2012-10-15 | 2012-10-15 tot 2012-10-16 |

  Abstract Scenario: datum aanvang vorige adreshouding ligt in onzekerheidsperiode van onbekende aanvang adreshouding en peildatum ligt in de onzekerheidsperiode van gevraagde adreshouding <scenario>
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
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | datum aanvang volgende adreshouding | peildatum  | scenario                               |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-10 | op datum aanvang vorige adreshouding   |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-09 | vóór datum aanvang vorige adreshouding |
    | 20100501                          | 20100000                   | 20101203                            | 2010-05-01 | op datum aanvang vorige adreshouding   |
    | 20100501                          | 20100000                   | 20101203                            | 2010-04-30 | vóór datum aanvang vorige adreshouding |
    | 20101014                          | 00000000                   | 20160301                            | 2010-10-14 | op datum aanvang vorige adreshouding   |
    | 20101014                          | 00000000                   | 20160301                            | 2010-10-13 | vóór datum aanvang vorige adreshouding |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-27 | op datum aanvang volgende adreshouding |
    | 20100810                          | 20100800                   | 20100827                            | 2010-08-29 | na datum aanvang volgende adreshouding |
    | 20100501                          | 20100000                   | 20101203                            | 2010-12-03 | op datum aanvang volgende adreshouding |
    | 20100501                          | 20100000                   | 20101203                            | 2010-12-17 | na datum aanvang volgende adreshouding |
    | 20101014                          | 00000000                   | 20160301                            | 2016-03-01 | op datum aanvang volgende adreshouding |
    | 20101014                          | 00000000                   | 20160301                            | 2020-01-01 | na datum aanvang volgende adreshouding |

Rule: een persoon met deels onbekende aanvang adreshouding, deels onbekende aanvang vorige adreshouding en niet-overlappende onzekerheidsperiodes, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang vorige adreshouding niet en peildatum ligt in de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   |
    | 20100800                          | 20101000                   | 2010-10-31 | 2010-10-31 tot 2010-11-01 |
    | 20100800                          | 20110000                   | 2011-12-31 | 2011-12-31 tot 2012-01-01 |
    | 20100000                          | 20110200                   | 2011-02-01 | 2011-02-01 tot 2011-02-02 |
    | 20100000                          | 20110000                   | 2011-12-31 | 2011-12-31 tot 2012-01-01 |

  Abstract Scenario: onzekerheidsperiode van deels onbekende aanvang adreshouding overlapt onzekerheidsperiode van deels onbekende aanvang vorige adreshouding niet en peildatum ligt vóór de onzekerheidsperiode van gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  |
    | 20100800                          | 20101000                   | 2010-09-30 |
    | 20100800                          | 20110000                   | 2010-12-31 |
    | 20100800                          | 20101000                   | 2010-08-31 |
    | 20100800                          | 20110000                   | 2010-08-31 |
    | 20100000                          | 20110200                   | 2011-01-31 |
    | 20100000                          | 20110000                   | 2010-12-31 |
    | 20100000                          | 20110200                   | 2011-01-01 |

Rule: een persoon met onbekende aanvang adreshouding, onbekende aanvang vorige adreshouding en gelijke onzekerheidsperiode, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode ligt

  Abstract Scenario: onzekerheidsperiode van adreshouding komt overeen met onzekerheidsperiode van vorige adreshouding en peildatum ligt in de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   |
    | 00000000                          | 00000000                   | 2010-08-31 | 2010-08-31 tot 2010-09-01 |
    | 20100000                          | 20100000                   | 2010-01-01 | 2010-01-01 tot 2010-01-02 |
    | 20100500                          | 20100500                   | 2010-05-01 | 2010-05-01 tot 2010-05-02 |

  Abstract Scenario: onzekerheidsperiode van adreshouding komt overeen met onzekerheidsperiode van vorige adreshouding en peildatum ligt vóór de onzekerheidsperiode
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  |
    | 20100000                          | 20100000                   | 2009-12-31 |
    | 20100500                          | 20100500                   | 2010-04-30 |

Rule: een persoon met onbekend aanvang adreshouding, deels onbekende aanvang vorige adreshouding en deels/geheel overlappende onzekerheidsperiodes, is op peildatum een mogelijke bewoner als de peildatum in de onzekerheidsperiode van de adreshouding ligt én op of na de eerste dag van de onzekerheidsperiode van de vorige adreshouding

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding geheel en peildatum ligt op/na de eerste dag van de onzekerheidsperiode van vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   | opmerking                                                                            |
    | 20100000                          | 00000000                   | 2010-01-01 | 2010-01-01 tot 2010-01-02 | peildatum is de eerste dag in de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100000                          | 00000000                   | 2011-01-01 | 2011-01-01 tot 2011-01-02 | peildatum is de eerste dag na de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100500                          | 00000000                   | 2010-05-01 | 2010-05-01 tot 2010-05-02 | peildatum is de eerste dag in de onzekerheidsperiode van aanvang vorige adreshouding |
    | 20100500                          | 20100000                   | 2010-06-01 | 2010-06-01 tot 2010-06-02 | peildatum is de eerste dag na de onzekerheidsperiode van aanvang vorige adreshouding |

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding geheel en peildatum ligt vóór de onzekerheidsperiode van vorige adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  |
    | 20100000                          | 00000000                   | 2009-12-31 |
    | 20100500                          | 00000000                   | 2010-04-30 |
    | 20100500                          | 20100000                   | 2010-04-30 |

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding deels en peildatum ligt in de onzekerheidsperiode van de gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000002 |
    En heeft de bewoning een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  | periode                   |
    | 00000000                          | 20100000                   | 2010-01-01 | 2010-01-01 tot 2010-01-02 |
    | 00000000                          | 20100500                   | 2010-05-01 | 2010-05-01 tot 2010-05-02 |
    | 20100000                          | 20100800                   | 2010-08-01 | 2010-08-01 tot 2010-08-02 |

  Abstract Scenario: onzekerheidsperiode van adreshouding overlapt onzekerheidsperiode van vorige adreshouding deels en peildatum ligt vóór de onzekerheidsperiode van de gevraagde adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)  |
    | 0800                              | <datum aanvang vorige adreshouding> |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | <datum aanvang adreshouding>       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | datum aanvang vorige adreshouding | datum aanvang adreshouding | peildatum  |
    | 00000000                          | 20100000                   | 2009-12-31 |
    | 00000000                          | 20100500                   | 2010-04-30 |
    | 20100000                          | 20100800                   | 2010-07-31 |
