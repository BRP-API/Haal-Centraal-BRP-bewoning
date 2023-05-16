#language: nl

Functionaliteit: indicatie verblijfplaats in onderzoek leveren bij een bewoner

Rule: het in onderzoek zijn van één of meerdere verblijfplaats gegevens wordt vertaald naar indicatieVerblijfsplaatsInOnderzoek waarde true

  Abstract Scenario: '<type>' is in onderzoek
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) | aanduiding in onderzoek (83.10) |
    | 0518010000713450                         | 20100818                           | <aanduiding in onderzoek>       |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000854789                         | 20160526                           |
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
