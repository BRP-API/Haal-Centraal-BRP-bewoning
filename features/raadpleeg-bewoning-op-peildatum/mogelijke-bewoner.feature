#language: nl

Functionaliteit: raadpleeg bewoning op peildatum bij onzekere datum aanvang adreshouding

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000854789                         |

Rule: een persoon is mogelijk bewoner op elke peildatum als datum aanvang adreshouding op het adresseerbaar object geheel onbekend is en er is geen volgend adreshouding

  @MB-GO-GV
  Scenario: datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is geheel onbekend
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 00000000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-09-01           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-09-01 tot 2010-09-02 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-09-01 tot 2010-09-02' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: een persoon is mogelijk bewoner van een adresseerbaar object als de peildatum valt:
      - in de onzekerheidsperiode van het deels of geheel onbekend datum aanvang adreshouding op het adresseerbaar object of
      - in de onzekerheidsperiode van het deels of geheel onbekend datum aanvang adreshouding op het volgend adresseerbaar object

  @MB-IDO
  Abstract Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                           |
    | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding  |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding                |
    | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding |

  @IB-NDO-GV
  Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de eerste dag van de daarop volgende maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-09-01           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-09-01 tot 2010-09-02 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-09-01 tot 2010-09-02' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  @GB-VDO
  Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de laatste dag vóór datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-07-31           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-07-31 tot 2010-08-01 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-07-31 tot 2010-08-01' geen bewoners

  @WB-DO-VNOV
  Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt vóór volgend datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200701                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-06-30           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2020-06-30 tot 2020-07-01 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-06-30 tot 2020-07-01' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  @GB-DO-NNOV
  Scenario: persoon verbleef vanaf onbekend dag in datum aanvang adreshouding op aangegeven adresseerbaar object en peildatum ligt op/na volgend datum aanvang adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200701                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-07-01           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2020-07-01 tot 2020-07-02 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-06-30 tot 2020-07-01' geen bewoners

  @MB-DO-IDOV
  Abstract Scenario: dag datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                                           |
    | 2016-05-01 | 2016-05-01 tot 2016-05-02 | peildatum valt op de eerste dag van de maand van de volgende aanvang adreshouding  |
    | 2016-05-18 | 2016-05-18 tot 2016-05-19 | peildatum valt binnen de maand van de volgende aanvang adreshouding                |
    | 2016-05-31 | 2016-05-31 tot 2016-06-01 | peildatum valt op de laatste dag van de maand van de volgende aanvang adreshouding |

  @GB-NO-NDOV
  Scenario: dag datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de eerste dag van de daarop volgende maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2016-06-01           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2016-06-01 tot 2016-06-02 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2016-06-01 tot 2016-06-02' geen bewoners

  @WB-NO-VDOV
  Scenario: dag datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de laatste dag van de vorige maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2016-04-30           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2016-04-30 tot 2016-05-01 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2016-04-30 tot 2016-05-01' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  @MB-IDO
  Abstract Scenario: dag en maand datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                           |
    | 2010-01-01 | 2010-01-01 tot 2010-01-02 | peildatum valt op de eerste dag van het jaar aanvang adreshouding  |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen het jaar aanvang adreshouding                |
    | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum valt op de laatste dag van het jaar aanvang adreshouding |

  @IB-NDO-GV
  Scenario: dag en maand datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de eerste dag van het daarop volgend jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2011-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2011-01-01 tot 2011-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2011-01-01 tot 2011-01-02' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  @GB-VDO
  Scenario: dag en maand datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de laatste dag van het vorige jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2009-12-31           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2009-12-31 tot 2010-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2009-12-31 tot 2010-01-01' geen bewoners

  @MB-NO-IDOV
  Abstract Scenario: dag en maand datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                                           |
    | 2016-01-01 | 2016-01-01 tot 2016-01-02 | peildatum valt op de eerste dag van het jaar van de volgende aanvang adreshouding  |
    | 2016-05-18 | 2016-05-18 tot 2016-05-19 | peildatum valt binnen het jaar van de volgende aanvang adreshouding                |
    | 2016-12-31 | 2016-12-31 tot 2017-01-01 | peildatum valt op de laatste dag van het jaar van de volgende aanvang adreshouding |

  @GB-NO-NDOV
  Scenario: dag en maand datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de eerste dag van het daarop volgend jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2017-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2017-01-01 tot 2017-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2017-01-01 tot 2017-01-02' geen bewoners

  @WB-NO-VDOV
  Scenario: dag en maand datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de laatste dag van het vorig jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2015-12-31           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2015-12-31 tot 2016-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2015-12-31 tot 2016-01-01' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
