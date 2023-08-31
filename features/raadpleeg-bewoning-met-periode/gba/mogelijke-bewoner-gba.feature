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

Rule: een persoon met onbekende aanvang adreshouding, geen vorige en volgende adreshouding, is in een periode een mogelijke bewoner als de periode in de onzekerheidsperiode van de gevraagde adreshouding ligt

  Abstract Scenario: aanvang adreshouding is deels/geheel onbekend en periode ligt in de onzekerheidsperiode van de adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | <datum aanvang adreshouding>       |
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

  Abstract Scenario: aanvang adreshouding is deels onbekend en periode overlapt deels/geheel de onzekerheidsperiode en deels de zekerheidsperiode van de adreshouding
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | <datum aanvang adreshouding>       |
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
