#language: nl

@gba
Functionaliteit: indicatie verblijfplaats in onderzoek leveren bij een bewoner bij het raadplegen van bewoning op peildatum

  Als consumer van de Bewoning API
  wil ik een indicatie krijgen wanneer de verblijfplaats gegevens van een bewoner in onderzoek staan
  zodat ik deze informatie kan gebruiken in mijn proces

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |

Rule: het in onderzoek zijn van de 'identificatiecode verblijfplaats' en/of 'datum aanvang adreshouding' gegevens van een persoon wordt vertaald naar het inOnderzoek veld van een bewoner met waarde true

  Abstract Scenario: '<type>' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 20100818                           | <aanduiding in onderzoek>       | 20200401                       |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-04-15           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-04-15 tot 2020-04-16 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning een bewoner met de volgende gegevens
    | burgerservicenummer | verblijfplaatsInOnderzoek.aanduidingGegevensInOnderzoek | verblijfplaatsInOnderzoek.datumIngangOnderzoek |
    | 000000024           | <aanduiding in onderzoek>                               | 20200401                                       |

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
    | 089999                  | vastgesteld verblijft niet op adres |

Rule: datum ingang onderzoek is niet relevant voor het wel/niet leveren van het inOnderzoek veld met waarde true

  Abstract Scenario: 'hele categorie verblijfplaats' is in onderzoek en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) |
    | 20100818                           | 080000                          | 20200401                       |
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
    En heeft de bewoner de volgende 'verblijfplaatsInOnderzoek' gegevens
    | aanduidingGegevensInOnderzoek | datumIngangOnderzoek |
    | 080000                        | 20200401             |

    Voorbeelden:
    | peildatum  | periode                   | scenario                                   |
    | 2020-03-31 | 2020-03-31 tot 2020-04-01 | peildatum ligt vóór datum ingang onderzoek |
    | 2020-04-01 | 2020-04-01 tot 2020-04-02 | peildatum ligt op datum ingang onderzoek   |
    | 2020-05-01 | 2020-05-01 tot 2020-05-02 | peildatum ligt na datum ingang onderzoek   |

Rule: een beëindigd onderzoek wordt nooit vertaald naar het inOnderzoek veld, ook niet als de peildatum valt binnen de onderzoek periode

  Abstract Scenario: het in onderzoek zijn van 'hele categorie verblijfplaats' is beëindigd en <scenario>
    Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 20100818                           | 080000                          | 20200401                       | 20200801                      |
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
    | peildatum  | periode                   | scenario                                                               |
    | 2020-03-31 | 2020-03-31 tot 2020-04-01 | peildatum ligt vóór datum ingang onderzoek                             |
    | 2020-04-01 | 2020-04-01 tot 2020-04-02 | peildatum ligt op datum ingang onderzoek                               |
    | 2020-05-01 | 2020-05-01 tot 2020-05-02 | peildatum ligt na datum ingang onderzoek en vóór datum einde onderzoek |
    | 2020-08-01 | 2020-08-01 tot 2020-08-02 | peildatum ligt na datum einde onderzoek                                |
