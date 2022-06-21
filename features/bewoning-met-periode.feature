#language: nl

@gba
Functionaliteit: raadpleeg bewoning met adresseerbaarObjectIdentificatie en periode

    Achtergrond:
      Gegeven het systeem heeft personen met de volgende 'verblijfplaats' gegevens
      | burgerservicenummer | Datum aanvang adreshouding (10.30) | Straatnaam (11.10)       | Identificatiecode verblijfplaats (11.80) | Functie adres (10.10) |
      | 555550001           | 20100818                           | Wilhelmina van Pruisenwg | 0518010000713450                         | W                     |
      | 555550001           | 20160526                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550002           | 20160601                           | Wilhelmina van Pruisenwg | 0518010000713450                         | W                     |
      | 555550003           | 20091001                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550003           | 20191112                           | Wilhelmina van Pruisenwg | 0518010000713450                         | W                     |
      | 555550004           | 20080315                           | Spui                     | 0518010000747448                         | W                     |
      | 555550004           | 20190603                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550005           | 20100315                           | Nassaulaan               | 0518010000637600                         | W                     |
      | 555550006           | 20100315                           | Nassaulaan               | 0518010000637600                         | W                     |
      | 555550006           | 20140401                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550006           | 20180210                           | Nassaulaan               | 0518010000637600                         | W                     |
      | 555550010           | 20200400                           | Nieuwe Schoolstraat      | 0518010000694355                         | W                     |
      | 555550011           | 20200000                           | Trompstraat              | 0518010000541555                         | W                     |
      | 555550012           | 00000000                           | Hobbemastraat            | 0518010001667593                         | W                     |
      | 555550012           | 20211014                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550013           | 20130101                           | Bezuidenhoutseweg        | 0518010000438780                         | W                     |
      | 555550013           | 20200300                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550014           | 20130101                           | Parnassusplein           | 0518010001643075                         | W                     |
      | 555550014           | 20200000                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550015           | 20130101                           | Rijnstraat               | 0518010000518265                         | W                     |
      | 555550015           | 00000000                           | Ypenburgse Boslaan       | 0518010000854789                         | W                     |
      | 555550016           | 20200000                           | Anna van Hannoverstraat  | 0518010001758003                         | W                     |
      | 555550017           | 20200701                           | Anna van Hannoverstraat  | 0518010001758003                         | W                     |
      | 555550020           | 20100818                           | Leyweg                   | 0599010000156729                         | W                     |
      | 555550021           | 20100818                           | Bronovolaan              | 0518010000460415                         | W                     |
      | 555550022           | 20100818                           | Stadhouderslaan          | 0518010000507214                         | W                     |
      | 555550023           | 20101113                           | Korte Voorhout           | 0518010000757426                         | W                     |
      En het systeem heeft personen met de volgende 'verblijfplaats' gegevens
      | burgerservicenummer | Datum aanvang adres buitenland (13.20) | Land adres buitenland (13.10) |
      | 555550002           | 20171101                               | 5003                          |
      En het systeem heeft personen met de volgende 'overlijden' gegevens
      | burgerservicenummer | Datum overlijden (08.10) |
      | 555550020           | 20200917                 |
      | 555550021           | 20200800                 |
      | 555550022           | 20200000                 |
      | 555550023           | 00000000                 |

  @gba
  Rule: er wordt een bewoningperiode opgenomen voor elke unieke samenstelling van bewoners, waarvoor geldt:
    - de periode van een bewoningPeriode loopt van de jongste datum aanvang tot de oudste datum aanvang van de volgende verblijfplaats
    - wanneer de periode datumVan van een bewoningPeriode kleiner is dan gevraagde datumVan, is de periode datumVan gelijk aan de gevraagde datumVan
    - wanneer de periode datumTot van een bewoningPeriode groter is dan gevraagde datumTotEnMet, is de periode datumTot gelijk aan de gevraagde datumTotEnMet + 1 dag
    - in de bewoningPeriode zijn alle bewoners opgenomen die tijdens deze periode op dit adresseerbaar object stonden ingeschreven
    - voor elke bewoner wordt de betreffende verblijfplaats geleverd plus de datum aanvang van de volgende verblijfplaats van die persoon
    - alleen de bewonerPeriodes die ten minste één dag overlap hebben met de gevraagde periode worden geleverd
    - de periode van de bewoning loopt van de eerste dag van de oudste bewoningPeriode tot de laatste dag van de jongste bewoningPeriode

    Scenario: periode valt volledig binnen bewoning begin en einddatum van de bewoner
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2012-01-01                                        |
      | datumTotEnMet                    | 2012-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2012-01-01 |
      | datumTot.datum | 2013-01-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100818 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20160526 |

    Scenario: volgende verblijfplaats van de bewoner is in het buitenland
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2017-01-01                                        |
      | datumTotEnMet                    | 2017-06-30                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2017-01-01 |
      | datumTot.datum | 2017-07-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20160601 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                        | waarde    |
      | datumAanvangAdresBuitenland | 201701101 |

    Scenario: bewoner woont nog op gevraagde adresseerbaar object
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2022-01-01                                        |
      | datumTotEnMet                    | 2022-06-15                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2022-01-01 |
      | datumTot.datum | 2022-06-16 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550003 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20191112 |
      | functieAdres             | W        |
      En heeft deze bewoner exact 1 'verblijfplaats' 

    Scenario: periode ligt voor eerste bewoning
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2009-01-01                                        |
      | datumTotEnMet                    | 2009-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2009-01-01 |
      | datumTot.datum | 2010-01-01 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

    Scenario: periode ligt na laatste bewoning
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-01-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000747448                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000747448' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2020-01-01 |
      | datumTot.datum | 2021-01-01 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

    Scenario: periode ligt tussen twee bewoningen
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2018-01-01                                        |
      | datumTotEnMet                    | 2018-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2018-01-01 |
      | datumTot.datum | 2010-01-01 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

    Scenario: in periode was er tijdelijk geen bewoning
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2016-01-01                                        |
      | datumTotEnMet                    | 2016-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2016-01-01 |
      | datumTot.datum | 2016-05-26 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550001 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100818 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20160526 |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2016-05-26 |
      | datumTot.datum | 2016-06-01 |
      En heeft deze bewoningPeriode GEEN 'bewoners'
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2016-06-01 |
      | datumTot.datum | 2017-01-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550002 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20160601 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20171101 |

    Scenario: eerste deel van periode is er geen bewoning
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2019-07-01                                        |
      | datumTotEnMet                    | 2019-11-10                                        |
      | adresseerbaarObjectIdentificatie | 0518010000713450                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2019-07-01 |
      | datumTot.datum | 2019-11-06 |
      En heeft deze bewoningPeriode GEEN 'bewoners'
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2019-11-06 |
      | datumTot.datum | 2019-11-11 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20191106 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20210603 |

    Scenario: inverhuizingen tijdens periode
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2018-01-01                                        |
      | datumTotEnMet                    | 2018-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000637600                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2018-01-01 |
      | datumTot.datum | 2018-02-10 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2018-02-10 |
      | datumTot.datum | 2019-01-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550006 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20180210 |
      | functieAdres             | W        |

    Scenario: uitverhuizingen tijdens periode
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2014-01-01                                        |
      | datumTotEnMet                    | 2014-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000637600                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2014-01-01 |
      | datumTot.datum | 2014-04-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550006 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20140401 |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2014-04-01 |
      | datumTot.datum | 2015-01-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |

    Scenario: uitverhuizen en daarna weer inverhuizen
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2014-01-01                                        |
      | datumTotEnMet                    | 2018-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000637600                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2014-01-01 |
      | datumTot.datum | 2014-04-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550006 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20140401 |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2014-04-01 |
      | datumTot.datum | 2018-02-10 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000637600' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2018-02-10 |
      | datumTot.datum | 2019-01-01 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550005 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100315 |
      | functieAdres             | W        |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550006 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20180210 |
      | functieAdres             | W        |

    Scenario: datumTotEnMet is gelijk aan de datum aanvang adreshouding
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2019-05-03                                        |
      | datumTotEnMet                    | 2019-06-03                                        |
      | adresseerbaarObjectIdentificatie | 0518010000747448                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000747448' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2019-06-03 |
      | datumTot.datum | 2019-06-04 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20080315 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20190603 |

    Scenario: datumVan is gelijk aan de datum aanvang adreshouding van de volgende (andere) verblijfplaats
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2019-06-03                                        |
      | datumTotEnMet                    | 2019-07-03                                        |
      | adresseerbaarObjectIdentificatie | 0518010000747448                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000747448' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2019-06-03 |
      | datumTot.datum | 2019-06-04 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550004 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20080315 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20190603 |

    Scenario: adresseerbaar object is nooit bewoond geweest
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-01-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 1234017890123456                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000713450' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2020-01-01 |
      | datumTot.datum | 2020-01-01 |
      En heeft deze bewoningPeriode GEEN 'bewoners'
  
  @gba
  Rule: in geval van een (gedeeltelijk) onbekende datum aanvang of datum einde van de bewoning, wordt de persoon voor de hele onzekerheidsperiode zowel als bewoner en als niet-bewoner opgenomen

    Abstract Scenario: gevraagde periode eindigt in onzekerheidsperiode <type> van datum aanvang van bewoning
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2019-12-31                                        |
      | datumTotEnMet                    | <datumTotEnMet>                                   |
      | adresseerbaarObjectIdentificatie | <identificatie>                                   |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2019-12-31 |
      | datumTot.type  | <type>     |
      | datumTot.jaar  | <jaar>     |
      | datumTot.maand | <maand>    |
      En heeft deze bewoningPeriode GEEN 'bewoners'
      En heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde          |
      | datumVan.type  | <type>          |
      | datumVan.jaar  | <jaar>          |
      | datumVan.maand | <maand>         |
      | datumTot.datum | <datumTotEnMet> |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde         |
      | datumAanvangAdreshouding | <datumAanvang> |
      | functieAdres             | W              |

      Voorbeelden:
      | identificatie    | burgerservicenummer | type           | jaar | maand | datumTotEnMet | datumAanvang |
      | 0518010000694355 | 555550010           | JaarMaandDatum | 2020 | 4     | 2020-04-01    | 20200400     |
      | 0518010000541555 | 555550011           | JaarDatum      | 2020 |       | 2020-01-01    | 20200000     |

    Scenario: datum aanvang van bewoning is volledig onbekend
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-01-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010001667593                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001667593' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde        |
      | datumVan.datum | 2020-01-01    |
      | datumTot.type  | DatumOnbekend |
      En heeft deze bewoningPeriode GEEN 'bewoners'
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001667593' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde        |
      | datumVan.type  | DatumOnbekend |
      | datumTot.datum | 2020-12-31    |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550012 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 00000000 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20211014 |

    Abstract Scenario: gevraagde periode begin in onzekerheidsperiode <type> van datum aanvang van de volgende (andere) verblijfplaats
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | <datumVan>                                        |
      | datumTotEnMet                    | 2021-03-31                                        |
      | adresseerbaarObjectIdentificatie | <identificatie>                                   |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | <datumVan> |
      | datumTot.type  | <type>     |
      | datumTot.jaar  | <jaar>     |
      | datumTot.maand | <maand>    |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20130101 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde         |
      | datumAanvangAdreshouding | <datumAanvang> |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde     |
      | datumVan.type  | <type>     |
      | datumVan.jaar  | <jaar>     |
      | datumVan.maand | <maand>    |
      | datumTot.datum | 2021-04-01 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

      Voorbeelden:
      | identificatie    | burgerservicenummer | type           | jaar | maand | datumVan   | datumAanvang |
      | 0518010000438780 | 555550013           | JaarMaandDatum | 2020 | 3     | 2020-03-31 | 20200300     |
      | 0518010001643075 | 555550014           | JaarDatum      | 2020 |       | 2020-12-31 | 20200000     |

    Scenario: datum aanvang van volgende (andere) bewoning is volledig onbekend
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-01-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010001667593                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001667593' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde        |
      | datumVan.datum | 2020-01-01    |
      | datumTot.type  | DatumOnbekend |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550015 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20130101 |
      | functieAdres             | W        |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 00000000 |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001667593' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde        |
      | datumVan.type  | DatumOnbekend |
      | datumTot.datum | 2020-12-31    |
      En heeft deze bewoningPeriode GEEN 'bewoners'

    Scenario: tijdens onzekerheidsperiode van datum aanvang verhuist een andere bewoner in
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-01-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010001758003                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001758003' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde        |
      | datumVan.datum | 2020-01-01    |
      | datumTot.type  | DatumOnbekend |
      En heeft deze bewoningPeriode GEEN 'bewoners'
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001758003' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde        |
      | datumVan.type  | DatumOnbekend |
      | datumTot.datum | 2020-07-01    |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550016 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 00000000 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010001758003' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde     |
      | datumVan.datum | 2020-07-01 |
      | datumTot.datum | 2020-12-31 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550016 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 00000000 |
      | functieAdres             | W        |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde    |
      | burgerservicenummer | 555550017 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20200701 |
      | functieAdres             | W        |

  Rule: een overleden persoon is geen bewoner (meer)
    - in het geval van een gedeeltelijk onbekende overlijdensdatum, wordt de persoon voor de hele onzekerheidsperiode wel als bewoner opgenomen
    - in het geval van een volledig onbekende overlijdensdatum, wordt de persoon wel als bewoner opgenomen
    - de gedeeltelijk onbekende overlijdensdatum wordt als datumTot en datumVan van de bewoningPeriodes opgenomen

    Scenario: vragen bewoning na overlijdensdatum van bewoner
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-10-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0599010000156729                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0599010000156729' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2020-10-01 |
      | datumTot.datum | 2020-12-31 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

    Scenario: persoon is overleden in de gevraagde periode
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-01-01                                        |
      | datumTotEnMet                    | 2020-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0599010000156729                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0599010000156729' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2020-01-01 |
      | datumTot.datum | 2020-09-17 |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | 555550020 |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100818 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0599010000156729' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2020-09-17 |
      | datumTot.datum | 2020-12-31 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

    Abstract Scenario: persoon is overleden in de gevraagde periode met <type>
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2019-01-01                                        |
      | datumTotEnMet                    | 2021-12-31                                        |
      | adresseerbaarObjectIdentificatie | <identificatie>                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2019-01-01 |
      | datumTot.type  | <type>     |
      | datumTot.jaar  | <jaar>     |
      | datumTot.maand | <maand>    |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | <burgerservicenummer> |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100818 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.type  | <type>     |
      | datumVan.jaar  | <jaar>     |
      | datumVan.maand | <maand>    |
      | datumTot.datum | 2021-12-31 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

      Voorbeelden:
      | identificatie    | burgerservicenummer | type           | jaar | maand |
      | 0518010000460415 | 555550021           | JaarMaandDatum | 2020 | 8     |
      | 0518010000507214 | 555550022           | JaarDatum      | 2020 |       |

    Abstract Scenario: gevraagde periode in onzekerheidsperiode <type> van overlijden bewoner
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2020-08-01                                        |
      | datumTotEnMet                    | 2020-08-31                                        |
      | adresseerbaarObjectIdentificatie | <identificatie>                                   |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde     |
      | datumVan.datum | 2020-08-01 |
      | datumTot.type  | <type>     |
      | datumTot.jaar  | <jaar>     |
      | datumTot.maand | <maand>    |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens
      | naam                | waarde                |
      | burgerservicenummer | <burgerservicenummer> |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100818 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde     |
      | datumVan.type  | <type>     |
      | datumVan.jaar  | <jaar>     |
      | datumVan.maand | <maand>    |
      | datumTot.datum | 2020-08-31 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

      Voorbeelden:
      | identificatie    | burgerservicenummer | type           | jaar | maand |
      | 0518010000460415 | 555550021           | JaarMaandDatum | 2020 | 8     |
      | 0518010000507214 | 555550022           | JaarDatum      | 2020 |       |

    Abstract Scenario: gevraagde periode na onzekerheidsperiode <type> van overlijden bewoner
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | <datumVan>                                        |
      | datumTotEnMet                    | 2021-12-31                                        |
      | adresseerbaarObjectIdentificatie | <identificatie>                                   |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '<identificatie>' een bewoningPeriode met de volgende 'periode' gegevens
      | naam           | waarde     |
      | datumVan.datum | <datumVan> |
      | datumTot.datum | 2021-12-31 |
      En heeft deze bewoningPeriode GEEN 'bewoners'

      Voorbeelden:
      | identificatie    | burgerservicenummer | datumVan   |
      | 0518010000460415 | 555550021           | 2020-09-01 |
      | 0518010000507214 | 555550022           | 2021-01-01 |

    Scenario: overlijdensdatum van de persoon is volledig onbekend
      Als bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                                            |
      | type                             | BewoningMetPeriode                                |
      | datumVan                         | 2021-01-01                                        |
      | datumTotEnMet                    | 2021-12-31                                        |
      | adresseerbaarObjectIdentificatie | 0518010000757426                                  |
      | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriodes |
      Dan heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000757426' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde        |
      | datumVan.datum | 2021-01-01    |
      | datumTot.type  | DatumOnbekend |
      En heeft deze bewoningPeriode met een 'bewoner' met de volgende gegevens 
      | naam                | waarde    |
      | burgerservicenummer | <burgerservicenummer> |
      En heeft deze bewoner een 'verblijfplaats' met de volgende gegevens
      | naam                     | waarde   |
      | datumAanvangAdreshouding | 20100818 |
      | functieAdres             | W        |
      En heeft de bewoning met adresseerbaarObjectIdentificatie '0518010000757426' een bewoningPeriode met de volgende 'periode' gegevens 
      | naam           | waarde        |
      | datumVan.type  | DatumOnbekend |
      | datumTot.datum | 2021-12-31    |
      En heeft deze bewoningPeriode GEEN 'bewoners'




    Scenario: verschillende adressen op zelfde adresseerbaar object
    Scenario: hernummering van adres
    @fout-case
    Scenario: adresseerbaarObjectIdentificatie 15 cijfers
    @fout-case
    Scenario: datumVan ligt na datumTotEnMet
    @fout-case
    Scenario: datumVan ligt na vandaag
    @fout-case
    Scenario: datumTotEnMet ligt na vandaag