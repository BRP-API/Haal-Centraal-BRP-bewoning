#language: nl

@gba
Functionaliteit: raadpleeg bewoning op peildatum

  Als consumer van de Bewoning API
  wil ik kunnen opvragen welke personen op een datum op een adresseerbaar object verblijven/hebben verbleven
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
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20160526                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | 20230526                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20140808                           |

Rule: er wordt geen bewoning geleverd voor een adresseerbaar object dat niet is geregistreerd in de BRP

  Scenario: bewoning wordt gevraagd van een niet-bestaand adresseerbaar object
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-17           |
    | adresseerbaarObjectIdentificatie | 0800000000000003     |
    Dan heeft de response 0 bewoningen

Rule: een persoon is op een peildatum bewoner van een adresseerbaar object als:
      - de persoon op het adresseerbaar object verblijft/heeft verbleven én
      - de peildatum valt op of na datum aanvang adreshouding van de persoon op het adresseerbaar object én
      - de peildatum valt vóór datum aanvang adreshouding van de persoon op het volgend adresseerbaar object

  Abstract Scenario: persoon verbleef op het gevraagde adresseerbaar object en <scenario>
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
    | peildatum  | periode                   | scenario                                                                                           |
    | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt in de adreshouding periode                                                          |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt op de eerste dag van adreshouding periode                                           |
    | 2014-08-07 | 2014-08-07 tot 2014-08-08 | peildatum valt op de laatste dag vóór adreshouding van persoon met burgerservicenummer '000000048' |

  Abstract Scenario: persoon heeft het gevraagde adresseerbaar object als briefadres opgegeven en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' heeft adres 'A3' als briefadres opgegeven met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000003     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | peildatum  | periode                   | scenario                                                                                           |
    | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt in de adreshouding periode                                                          |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt op de eerste dag van adreshouding periode                                           |
    | 2014-08-07 | 2014-08-07 tot 2014-08-08 | peildatum valt op de laatste dag vóór adreshouding van persoon met burgerservicenummer '000000048' |

  Abstract Scenario: meerdere personen verblijven/verbleven op de peildatum op het gevraagde adresseerbaar object
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

    Voorbeelden:
    | peildatum  | periode                   | opmerking                                                                                                    |
    | 2014-08-08 | 2014-08-08 tot 2014-08-09 | peildatum valt op de eerste dag van de adreshouding periode van bewoner met burgerservicenummer '000000048'  |
    | 2015-01-01 | 2015-01-01 tot 2015-01-02 | peildatum valt in de adreshouding periode van beide bewoners                                                 |
    | 2016-05-25 | 2016-05-25 tot 2016-05-26 | peildatum valt op de laatste dag van de adreshouding periode van bewoner met burgerservicenummer '000000024' |

Rule: er wordt geen bewoning geleverd voor een adresseerbaar object als er op de peildatum geen personen staan ingeschreven

  Scenario: persoon verbleef op het gevraagde adresseerbaar object en peildatum valt vóór datum aanvang adreshouding
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-17           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

  Abstract Scenario: <omschrijving>
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | peildatum  | periode                   | omschrijving                                                                               |
    | 2023-05-26 | 2023-05-26 tot 2023-05-27 | persoon verbleef op het gevraagde adresseerbaar object en is geëmigreerd op de peildatum   |
    | 2023-06-01 | 2023-06-01 tot 2023-06-02 | persoon verbleef op het gevraagde adresseerbaar object en is geëmigreerd vóór de peildatum |

  Scenario: persoon verbleef op het gevraagde adresseerbaar object en is geëmigreerd na de peildatum
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-05-25           |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2023-05-25 tot 2023-05-26 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
