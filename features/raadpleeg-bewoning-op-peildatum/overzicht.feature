#language: nl

Functionaliteit: raadpleeg bewoning op peildatum

  Als consumer van de Bewoning API
  wil ik de bewoners van een Adresseerbaar object op een datum kunnen opvragen
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    En een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000854789                         |

Rule: een persoon is bewoner van een adresseerbaar object op een peildatum als:
      - de peildatum valt op of na datum aanvang adreshouding van de persoon op het adresseerbaar object en
      - de peildatum valt vóór datum aanvang adreshouding van de persoon op het volgend adresseerbaar object

  Abstract Scenario: er is één persoon ingeschreven op het aangegeven adresseerbaar object en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                  |
    | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt in de adreshouding periode                 |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt op de eerste dag van adreshouding periode  |
    | 2016-05-25 | 2016-05-25 tot 2016-05-26 | peildatum valt op de laatste dag van adreshouding periode |

  Abstract Scenario: er zijn geen personen ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

    Voorbeelden:
    | peildatum  | periode                   | opmerking                                                     |
    | 2010-08-17 | 2010-08-17 tot 2010-08-18 | peildatum valt op laatste dag van vorig adreshouding periode  |
    | 2016-05-26 | 2016-05-26 tot 2016-05-27 | peildatum valt op eerste dag van volgend adreshouding periode |

  Abstract Scenario: de bewoner is geëmigreerd <omschrijving>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | 20230526                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

    Voorbeelden:
    | peildatum  | periode                   | omschrijving      |
    | 2023-05-26 | 2023-05-26 tot 2023-05-27 | op de peildatum   |
    | 2023-06-01 | 2023-06-01 tot 2023-06-02 | voor de peildatum |

  Scenario: de bewoner is geëmigreerd na de peildatum
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | 20230526                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-05-25           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2023-05-25 tot 2023-05-26 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2023-05-25 tot 2023-05-26' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: er zijn meerdere personen ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20140808                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

    Voorbeelden:
    | peildatum  | periode                   | opmerking                                                                                                    |
    | 2014-08-08 | 2014-08-08 tot 2014-08-09 | peildatum valt op de eerste dag van de adreshouding periode van bewoner met burgerservicenummer '000000048'  |
    | 2015-01-01 | 2015-01-01 tot 2015-01-02 | peildatum valt in de adreshouding periode van beide bewoners                                                 |
    | 2016-05-25 | 2016-05-25 tot 2016-05-26 | peildatum valt op de laatste dag van de adreshouding periode van bewoner met burgerservicenummer '000000024' |

Rule: een persoon is mogelijk bewoner van een adresseerbaar object op een peildatum als:
      - datum aanvang adreshouding van de persoon op het adresseerbaar object deels of geheel onbekend is en de peildatum valt in de onzekerheidsperiode
      - datum aanvang adreshouding van de persoon op het volgend adresseerbaar object deels of geheel onbekend is en de peildatum valt in de onzekerheidsperiode

  Abstract Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                           |
    | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding  |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding                |
    | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding |

  Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de eerste dag van de daarop volgende maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-09-01           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-09-01 tot 2010-09-02 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-09-01 tot 2010-09-02' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: dag datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de laatste dag van de vorige maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-07-31           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-07-31 tot 2010-08-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-07-31 tot 2010-08-01' geen bewoners

  Abstract Scenario: dag datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                                           |
    | 2016-05-01 | 2016-05-01 tot 2016-05-02 | peildatum valt op de eerste dag van de maand van de volgende aanvang adreshouding  |
    | 2016-05-18 | 2016-05-18 tot 2016-05-19 | peildatum valt binnen de maand van de volgende aanvang adreshouding                |
    | 2016-05-31 | 2016-05-31 tot 2016-06-01 | peildatum valt op de laatste dag van de maand van de volgende aanvang adreshouding |

  Scenario: dag datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de eerste dag van de daarop volgende maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2016-06-01           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2016-06-01 tot 2016-06-02 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2016-06-01 tot 2016-06-02' geen bewoners

  Scenario: dag datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de laatste dag van de vorige maand
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2016-04-30           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2016-04-30 tot 2016-05-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2016-04-30 tot 2016-05-01' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: dag en maand datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                           |
    | 2010-01-01 | 2010-01-01 tot 2010-01-02 | peildatum valt op de eerste dag van het jaar aanvang adreshouding  |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen het jaar aanvang adreshouding                |
    | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum valt op de laatste dag van het jaar aanvang adreshouding |

  Scenario: dag en maand datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de eerste dag van het daarop volgend jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2011-01-01           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2011-01-01 tot 2011-01-02 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2011-01-01 tot 2011-01-02' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: dag en maand datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend en peildatum valt op de laatste dag van het vorige jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2009-12-31           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2009-12-31 tot 2010-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2009-12-31 tot 2010-01-01' geen bewoners

  Abstract Scenario: dag en maand datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                                           |
    | 2016-01-01 | 2016-01-01 tot 2016-01-02 | peildatum valt op de eerste dag van het jaar van de volgende aanvang adreshouding  |
    | 2016-05-18 | 2016-05-18 tot 2016-05-19 | peildatum valt binnen het jaar van de volgende aanvang adreshouding                |
    | 2016-12-31 | 2016-12-31 tot 2017-01-01 | peildatum valt op de laatste dag van het jaar van de volgende aanvang adreshouding |

  Scenario: dag en maand datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de eerste dag van het daarop volgend jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2017-01-01           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2017-01-01 tot 2017-01-02 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2017-01-01 tot 2017-01-02' geen bewoners

  Scenario: dag en maand datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is onbekend en peildatum valt op de laatste dag van het vorig jaar
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2015-12-31           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2015-12-31 tot 2016-01-01 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2015-12-31 tot 2016-01-01' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: een persoon is mogelijk bewoner van een adresseerbaar object op elke peildatum als de datum aanvang adreshouding van de persoon op het adresseerbaar object volledig onbekend is en er is geen inschrijving op een volgend adresseerbaar object

  Scenario: datum aanvang adreshouding van een persoon op het aangegeven adresseerbaar object is onbekend
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 00000000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-09-01           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-09-01 tot 2010-09-02 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-09-01 tot 2010-09-02' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: een persoon is alleen op datum aanvang adreshouding bewoner van een adresseerbaar object als de datum aanvang adreshouding op het volgend adresseerbaar object volledig onbekend is

  Scenario: datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is volledig onbekend en peildatum valt op de datum aanvang adreshouding op het eerste adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 00000000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-18           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-18 tot 2010-08-19 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-18 tot 2010-08-19' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is volledig onbekend en peildatum valt op de eerste dag na datum aanvang adreshouding op het eerste adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 00000000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-19           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-18 tot 2010-08-19 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-19 tot 2010-08-20' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
