#language: nl

Functionaliteit: verificatie gegevens leveren bij een bewoner

  Scenario: een persoon met verificatie gegevens is ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000152' heeft de volgende 'inschrijving' gegevens
    | datum verificatie (71.10) | omschrijving verificatie (71.20) |
    | 20020701                  | bewijs nationaliteit             |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20160526                           |
    En de 'verblijfplaats' heeft de volgende 'adres' gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000854789                         |
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
    | burgerservicenummer |
    | 000000024           |
    En heeft de bewoner de volgende 'verficatie' gegevens
    | naam              | waarde               |
    | datum.type        | Datum                |
    | datum.datum       | 2002-07-01           |
    | datum.langFormaat | 1 juli 2002          |
    | omschrijving      | bewijs nationaliteit |
