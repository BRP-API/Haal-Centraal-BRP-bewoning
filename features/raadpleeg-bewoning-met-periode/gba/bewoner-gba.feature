#language: nl

@gba
Functionaliteit: raadpleeg bewoning in periode

  Als consumer van de Bewoning API
  wil ik kunnen opvragen welke personen in een periode op een adresseerbaar object verblijven/hebben verbleven
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800000000000001                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800000000000002                         |
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
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20081103                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
    | 5010         | 20160428                               | Rue des poires 36                | Bruxelles                        | postcode 1000                    |

Rule: een persoon is binnen een periode bewoner van een adresseerbaar object als:
      - de van datum van de periode valt op of na datum aanvang adreshouding van de persoon op het adresseerbaar object
      - de tot datum van de periode valt vóór datum aanvang adreshouding van de persoon op het volgende adresseerbaar object

  Scenario: bewoning wordt gevraagd voor een periode die ligt binnen de verblijfperiode van één persoon op het adresseerbaar object
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-09-01         |
    | datumTot                         | 2014-08-01         |
    | adresseerbaarObjectIdentificatie | 0800000000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-09-01 tot 2014-08-01 |
    | adresseerbaarObjectIdentificatie | 0800000000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: bewoning wordt gevraagd voor een periode die ligt binnen de verblijfperiode van meerdere personen op het adresseerbaar object
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-09-01         |
    | datumTot                         | 2016-05-26         |
    | adresseerbaarObjectIdentificatie | 0800000000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-09-01 tot 2016-05-26 |
    | adresseerbaarObjectIdentificatie | 0800000000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

Rule: er wordt geen bewoning geleverd voor een gevraagde periode voor een adresseerbaar object als er binnen die periode geen personen verblijven/hebben verbleven op het adresseerbaar object

  Scenario: bewoning wordt gevraagd voor een periode die vóór de verblijfperiode van een persoon op het adresseerbaar object ligt
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2010-08-17         |
    | adresseerbaarObjectIdentificatie | 0800000000000001   |
    Dan heeft de response 0 bewoningen

Rule: er wordt geen bewoning geleverd voor een deel van de gevraagde periode voor een adresseerbaar object als er binnen dat deel van de periode geen personen verblijven/hebben verbleven op het adresseerbaar object

  Scenario: bewoning wordt gevraagd voor een periode dat deels vóór de verblijf periode van een persoon op het adresseerbaar object ligt
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2010-01-01         |
    | datumTot                         | 2011-01-01         |
    | adresseerbaarObjectIdentificatie | 0800000000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2010-08-18 tot 2011-01-01 |
    | adresseerbaarObjectIdentificatie | 0800000000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: bewoning wordt gevraagd voor een periode waarbinnen het adresseerbaar object tijdelijk niet bewoond was
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2016-01-01         |
    | datumTot                         | 2017-01-01         |
    | adresseerbaarObjectIdentificatie | 0800000000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2016-01-01 tot 2016-04-28 |
    | adresseerbaarObjectIdentificatie | 0800000000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000012           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2016-05-26 tot 2017-01-01 |
    | adresseerbaarObjectIdentificatie | 0800000000000002          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: er wordt voor een periode voor een adresseerbaar object meerdere bewoningen geleverd als binnen de gevraagde periode de samenstelling van bewoners verandert

  Scenario: bewoning wordt gevraagd voor een periode die ligt binnen de verblijfperiode van één persoon en deels binnen de verblijfperiode van een ander persoon op het adresseerbaar object
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2014-01-01         |
    | datumTot                         | 2016-05-01         |
    | adresseerbaarObjectIdentificatie | 0800000000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-01-01 tot 2014-08-08 |
    | adresseerbaarObjectIdentificatie | 0800000000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2014-08-08 tot 2016-05-01 |
    | adresseerbaarObjectIdentificatie | 0800000000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |
