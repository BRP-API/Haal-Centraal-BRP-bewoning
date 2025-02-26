#language: nl

@gba
Functionaliteit: indicatie verblijfplaats in onderzoek leveren bij een bewoner bij het raadplegen van bewoning in periode

  Als consumer van de Bewoning API
  wil ik een indicatie krijgen wanneer de verblijfplaats gegevens van een bewoner in onderzoek staan
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |

Rule: het in onderzoek zijn van verblijfplaats gegevens wordt ongevraagd geleverd

  Abstract Scenario: '<type>' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | <aanduiding in onderzoek>       | 20200401                       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-04-15         |
    | datumTot                         | 2021-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-04-15 tot 2021-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de bewoner de volgende 'verblijfplaatsInOnderzoek' gegevens
    | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | <aanduiding in onderzoek>     | 20200401             |

    Voorbeelden:
    | aanduiding in onderzoek | type                                |
    | 080000                  | hele categorie verblijfplaats       |
    | 080900                  | hele groep gemeente                 |
    | 080910                  | gemeente van inschrijving           |
    | 080920                  | datum inschrijving in de gemeente   |
    | 081000                  | hele groep adreshouding             |
    | 081030                  | datum aanvang adreshouding          |
    | 081100                  | hele groep adres                    |
    | 081180                  | identificatiecode verblijfplaats    |
    | 081010                  | functie adres                       |
    | 081110                  | straatnaam                          |
    | 081115                  | naam openbare ruimte                |
    | 081190                  | identificatiecode nummeraanduiding  |
    | 081200                  | hele groep locatie                  |
    | 081400                  | hele groep immigratie               |
    | 081410                  | land vanwaar ingeschreven           |
    | 081420                  | datum vestiging in Nederland        |
    | 088500                  | hele groep geldigheid               |
    | 088510                  | datum ingang geldigheid             |

  Abstract Scenario: '<type>' van vorige verblijfplaats is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | <aanduiding in onderzoek>       | 20200401                       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20210526                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-04-15         |
    | datumTot                         | 2021-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-04-15 tot 2021-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    En heeft de bewoner de volgende 'verblijfplaatsInOnderzoek' gegevens
    | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | <aanduiding in onderzoek>     | 20200401             |

    Voorbeelden:
    | aanduiding in onderzoek | type                             |
    | 580000                  | hele categorie verblijfplaats    |
    | 581000                  | hele groep adreshouding          |
    | 581030                  | datum aanvang adreshouding       |
    | 581100                  | hele groep adres                 |
    | 581180                  | identificatiecode verblijfplaats |


Rule: datum ingang onderzoek is niet relevant voor het wel/niet leveren van 'in onderzoek' gegevens

  Abstract Scenario: 'hele categorie verblijfplaats' is in onderzoek en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | 080000                          | 20200401                       |
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
    En heeft de bewoner de volgende 'verblijfplaatsInOnderzoek' gegevens
    | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | 080000                        | 20200401             |

    Voorbeelden:
    | datum van  | datum tot  | scenario                                            |
    | 2020-01-01 | 2020-03-31 | gevraagde periode ligt vóór datum ingang onderzoek  |
    | 2020-01-01 | 2020-04-01 | datumTot valt op datum ingang onderzoek             |
    | 2020-04-01 | 2021-01-01 | datumVan valt op datum ingang onderzoek             |
    | 2020-05-01 | 2021-01-01 | gevraagde periode ligt na datum ingang onderzoek    |
    | 2020-01-01 | 2021-01-01 | datum ingang onderzoek ligt in de gevraagde periode |


Rule: een beëindigd onderzoek wordt niet geleverd, ook niet als de gevraagde periode in de onderzoek periode ligt of geheel/deels overlapt

  Abstract Scenario: het in onderzoek zijn van 'hele categorie verblijfplaats' is beëindigd en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 0800                              | 20100818                           | 080000                          | 20200401                       | 20200801                      |
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
    | datum van  | datum tot  | scenario                                                             |
    | 2020-01-01 | 2020-03-31 | periode ligt vóór datum ingang onderzoek                             |
    | 2020-01-01 | 2020-04-01 | datumTot ligt op datum ingang onderzoek                              |
    | 2020-05-01 | 2020-07-01 | periode ligt na datum ingang onderzoek en vóór datum einde onderzoek |
    | 2020-09-01 | 2021-01-01 | periode ligt na datum einde onderzoek                                |
