#language: nl

Functionaliteit: raadpleeg bewoning op peildatum

  Als consumer van de Bewoning API
  wil ik de bewoners van een Adresseerbaar object op een datum kunnen opvragen
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000854789                         |

Rule: bewoning wordt alleen geleverd voor adresseerbare objecten die zijn geregistreerd in de BRP

  @BG
  Scenario: bewoning wordt gevraagd met de identificatie van een niet-geregistreerd adresseerbaar object
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-17           |
    | adresseerbaarObjectIdentificatie | 0800010000713451     |
    Dan heeft de response 0 bewoningen

Rule: een persoon is op de peildatum bewoner van een adresseerbaar object als de peildatum valt
      - op of na datum aanvang adreshouding op het adresseerbaar object en
      - er is geen volgende verblijf geregistreerd (de persoon verblijft nog op het adresseerbaar object)

  @IB-NNO-GV
  Abstract Scenario: <scenario> van een persoon op het gevraagde adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
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
    En heeft de bewoning voor de bewoningPeriode '<periode>' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                  |
    | 2010-09-01 | 2010-09-01 tot 2010-09-02 | de opgegeven peildatum valt in de adreshouding periode    |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | de opgegeven peildatum valt op datum aanvang adreshouding |

  @GB-VNO-GV
  Scenario: de opgegeven peildatum valt vóór datum aanvang adreshouding op het gevraagde adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-17           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-17 tot 2010-08-18 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-17 tot 2010-08-18' geen bewoners

Rule: een persoon was op de peildatum bewoner van een adresseerbaar object als de peildatum valt
      - op of na datum aanvang adreshouding op het adresseerbaar object en
      - vóór datum aanvang adreshouding op het volgend adresseerbaar object 

  @WB-NNO-VNOV
  Abstract Scenario: <scenario> van een persoon op het gevraagde adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
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
    En heeft de bewoning voor de bewoningPeriode '<periode>' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                               |
    | 2010-09-01 | 2010-09-01 tot 2010-09-02 | de opgegeven peildatum valt in de adreshouding periode                 |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | de opgegeven peildatum valt op datum aanvang adreshouding              |
    | 2016-05-25 | 2016-05-25 tot 2016-05-26 | de opgegeven peildatum valt op de laatste dag van adreshouding periode |

  Abstract Scenario: de opgegeven peildatum valt in de adreshouding periode van meerdere personen
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20140808                           |
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
    En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

    Voorbeelden:
    | peildatum  | periode                   |
    | 2014-08-08 | 2014-08-08 tot 2014-08-09 |
    | 2015-01-01 | 2015-01-01 tot 2015-01-02 |
    | 2016-05-25 | 2016-05-25 tot 2016-05-26 |

  @<case>
  Abstract Scenario: <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
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
    En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                                       | case        |
    | 2010-08-17 | 2010-08-17 tot 2010-08-18 | de opgegeven peildatum valt op laatste dag van het vorig adreshouding periode  | GB-VNO      |
    | 2016-05-26 | 2016-05-26 tot 2016-05-27 | de opgegeven peildatum valt op eerste dag van het volgend adreshouding periode | GB-NNO-NNOV |

  @GB-NNO-NNOV
  Abstract Scenario: <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | 20230526                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
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
    En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

    Voorbeelden:
      | peildatum  | periode                   | scenario                                    |
      | 2023-05-26 | 2023-05-26 tot 2023-05-27 | de bewoner is geëmigreerd op de peildatum   |
      | 2023-06-01 | 2023-06-01 tot 2023-06-02 | de bewoner is geëmigreerd vóór de peildatum |

  @WB-NNO-VNOV
  Scenario: de bewoner is geëmigreerd na de peildatum
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | 20230526                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-05-25           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2023-05-25 tot 2023-05-26 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2023-05-25 tot 2023-05-26' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: een persoon is alleen op datum aanvang adreshouding bewoner van een adresseerbaar object als de datum aanvang adreshouding op het volgend adresseerbaar object volledig onbekend is

  @WB-INO-IGOV
  Scenario: datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is volledig onbekend en peildatum valt op de datum aanvang adreshouding op het eerste adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 00000000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-18 tot 2010-08-19 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-18 tot 2010-08-19' een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  @MB-NNO-IGOV
  Scenario: datum aanvang adreshouding van een persoon op het volgend adresseerbaar object is volledig onbekend en peildatum valt op de eerste dag na datum aanvang adreshouding op het eerste adresseerbaar object
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 00000000                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-19           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-19 tot 2010-08-20 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-19 tot 2010-08-20' een mogelijke bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
