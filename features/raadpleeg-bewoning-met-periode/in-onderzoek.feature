#language: nl

Functionaliteit: indicatie verblijfplaats in onderzoek leveren bij een bewoner bij het raadplegen van bewoning op peildatum

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

Rule: het in onderzoek zijn van de 'identificatiecode verblijfplaats' en/of 'datum aanvang adreshouding' gegevens van een persoon wordt vertaald naar het inOnderzoek veld van een bewoner met waarde true

  Abstract Scenario: '<type>' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | <aanduiding in onderzoek>       | 20200401                       |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2021-07-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-01-01 tot 2021-07-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer | inOnderzoek |
    | 000000024           | true        |

    Voorbeelden:
    | aanduiding in onderzoek | type                             |
    | 080000                  | hele categorie verblijfplaats    |
    | 081000                  | hele groep adreshouding          |
    | 081010                  | functie adres                    |
    | 081030                  | datum aanvang adreshouding       |
    | 081100                  | hele groep adres                 |
    | 081180                  | identificatiecode verblijfplaats |

  Abstract Scenario: '<type>' van vorige verblijfplaats is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | <aanduiding in onderzoek>       | 20200401                       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20210803                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2021-07-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-01-01 tot 2021-07-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer | inOnderzoek |
    | 000000024           | true        |

    Voorbeelden:
    | aanduiding in onderzoek | type                             |
    | 580000                  | hele categorie verblijfplaats    |
    | 581000                  | hele groep adreshouding          |
    | 581010                  | functie adres                    |
    | 581030                  | datum aanvang adreshouding       |
    | 581100                  | hele groep adres                 |
    | 581180                  | identificatiecode verblijfplaats |

  Abstract Scenario: '<type>' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | <aanduiding in onderzoek>       | 20200401                       |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2021-07-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-01-01 tot 2021-07-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | aanduiding in onderzoek | type                               |
    | 080900                  | hele groep gemeente                |
    | 080910                  | gemeente van inschrijving          |
    | 080920                  | datum inschrijving in de gemeente  |
    | 081110                  | straatnaam                         |
    | 081115                  | naam openbare ruimte               |
    | 081190                  | identificatiecode nummeraanduiding |
    | 081200                  | hele groep locatie                 |
    | 081400                  | hele groep immigratie              |
    | 081410                  | land vanwaar ingeschreven          |
    | 081420                  | datum vestiging in Nederland       |
    | 088500                  | hele groep geldigheid              |
    | 088510                  | datum ingang geldigheid            |

  Scenario: onderzoek aanduiding 'vastgesteld verblijft niet meer op adres' wordt niet geleverd
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | 089999                          | 20220401                       |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2021-07-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-01-01 tot 2021-07-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: onderzoek aanduiding 'vastgesteld verblijft niet meer op adres' op vorige verblijfplaats wordt niet geleverd
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | 589999                          | 20210730                       |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20210803                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-01-01         |
    | datumTot                         | 2021-07-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-01-01 tot 2021-07-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: datum ingang onderzoek is niet relevant voor het wel/niet leveren van het inOnderzoek veld met waarde true

  Abstract Scenario: 'hele categorie verblijfplaats' is in onderzoek en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 0800                              | 20100818                           | 080000                          | 20200401                       |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <van>              |
    | datumTot                         | <tot>              |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <van> tot <tot>  |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer | inOnderzoek |
    | 000000024           | true        |

    Voorbeelden:
    | van        | tot        | scenario                                 |
    | 2020-01-01 | 2020-02-01 | periode ligt vóór datum ingang onderzoek |
    | 2020-03-01 | 2020-05-01 | periode bevat de datum ingang onderzoek  |
    | 2020-05-01 | 2020-07-01 | periode ligt na datum ingang onderzoek   |

Rule: een beëindigd onderzoek wordt nooit vertaald naar het inOnderzoek veld, ook niet als de peildatum valt binnen de onderzoek periode

  Abstract Scenario: het in onderzoek zijn van 'hele categorie verblijfplaats' is beëindigd en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 0800                              | 20100818                           | 080000                          | 20200401                       | 20200801                      |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <van>              |
    | datumTot                         | <tot>              |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <van> tot <tot>  |
    | adresseerbaarObjectIdentificatie | 0800010000000001 |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | van        | tot        | scenario                                                                       |
    | 2020-01-01 | 2020-04-01 | periode ligt vóór datum ingang onderzoek                                       |
    | 2020-03-01 | 2020-09-01 | periode begint vóór datum ingang onderzoek en eindigt na datum einde onderzoek |
    | 2020-05-01 | 2020-07-01 | periode valt tussen datum ingang onderzoek en datum einde onderzoek            |
    | 2020-09-01 | 2020-10-01 | periode ligt na datum einde onderzoek                                          |
