#language: nl

@gba
Functionaliteit: raadpleeg bewoning op peildatum bij nevenadressen

Rule: een persoon ingeschreven op een nevenadres wordt gezien als bewoner van het hoofdadres

  Scenario: een persoon staat ingeschreven op het nevenadres
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877405                           |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200022197986                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220818                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220818                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2023-01-01 tot 2023-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

