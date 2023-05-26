#language: nl

Functionaliteit: indicatie verblijfplaats in onderzoek leveren bij een bewoner

Rule: het in onderzoek zijn van één of meerdere verblijfplaats gegevens wordt vertaald naar indicatieVerblijfsplaatsInOnderzoek waarde true

  Abstract Scenario: '<type>' is in onderzoek en peildatum ligt op/na datum ingang onderzoek en vóór datum einde onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 20100818                           | <aanduiding in onderzoek>       | 20200401                       | 20200501                      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-04-15           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2020-04-15 tot 2020-04-16 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-04-15 tot 2020-04-16' een bewoner met de volgende gegevens
    | burgerservicenummer | indicatieVerblijfsplaatsInOnderzoek |
    | 000000024           | true                                |

    Voorbeelden:
    | aanduiding in onderzoek | type                               |
    | 080000                  | hele categorie verblijfplaats      |
    | 081000                  | hele groep adreshouding            |
    | 081010                  | functie adres                      |
    | 081030                  | datum aanvang adreshouding         |
    | 081100                  | hele groep adres                   |
    | 081180                  | identificatiecode verblijfplaats   |
    | 081190                  | identificatiecode nummeraanduiding |
    | 088500                  | hele groep geldigheid              |
    | 088510                  | datum ingang geldigheid            |

  Abstract Scenario: 'hele categorie verblijfplaats' is in onderzoek en peildatum ligt vóór datum ingang onderzoek of op/na datum einde onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) |
    | 20100818                           | 080000                          | 20200401                       | 20200501                      |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
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
    | peildatum  | periode                   | opmerking                                  |
    | 2020-03-31 | 2020-03-31 tot 2020-04-01 | peildatum ligt vóór datum ingang onderzoek |
    | 2020-05-01 | 2020-05-01 tot 2020-05-02 | peildatum ligt op datum einde onderzoek    |
    | 2021-01-01 | 2021-01-01 tot 2021-01-02 | peildatum ligt na datum einde onderzoek    |
