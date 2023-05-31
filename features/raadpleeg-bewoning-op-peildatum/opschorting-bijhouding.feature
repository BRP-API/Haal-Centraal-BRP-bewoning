#language: nl

Functionaliteit: opschorting bijhouding leveren bij een bewoner

Rule: personen met een afgevoerde persoonslijst worden niet gezien als bewoner

  Scenario: persoon heeft afgevoerde persoonslijst
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | F                                    |
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
    En heeft de bewoning voor de bewoningPeriode '2010-09-01 tot 2010-09-02' geen bewoners

Rule: personen op een logisch verwijderde persoonslijst worden niet gezien als bewoner

  Scenario: persoon is opgeschort met reden "W" (wissen)
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | W                                    |
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
    En heeft de bewoning voor de bewoningPeriode '2010-09-01 tot 2010-09-02' geen bewoners

Rule: opschorting bijhouding met aanduiding ongelijk aan "F" of "W" wordt altijd meegeleverd, ook als de peildatum vóór datum opschorting bijhouding ligt

  Abstract Scenario: persoon is opgeschort met reden "<reden opschorting bijhouding>" (<reden opschorting omschrijving>) en <scenario>
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
    | 20220829                             | <reden opschorting bijhouding>       |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-08-28           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2022-08-28 tot 2022-08-29 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2022-08-28 tot 2022-08-29' een bewoner met de volgende gegevens
    | burgerservicenummer | opschortingBijhouding.code     | opschortingBijhouding.omschrijving | opschortingBijhouding.datum.type | opschortingBijhouding.datum.datum | opschortingBijhouding.datum.langFormaat |
    | 000000024           | <reden opschorting bijhouding> | <reden opschorting omschrijving>   | Datum                            | 2022-08-29                        | 29 augustus 2022                        |

    Voorbeelden:
    | reden opschorting bijhouding | reden opschorting omschrijving | peildatum  | periode                   | scenario                                         |
    | O                            | overlijden                     | 2022-08-28 | 2022-08-28 tot 2022-08-29 | peildatum ligt vóór datum opschorting bijhouding |
    | O                            | overlijden                     | 2022-08-29 | 2022-08-29 tot 2022-08-30 | peildatum ligt op datum opschorting bijhouding   |
    | O                            | overlijden                     | 2022-09-01 | 2022-09-01 tot 2022-09-02 | peildatum ligt na datum opschorting bijhouding   |
    | E                            | emigratie                      | 2022-08-28 | 2022-08-28 tot 2022-08-29 | peildatum ligt vóór datum opschorting bijhouding |
    | E                            | emigratie                      | 2022-08-29 | 2022-08-29 tot 2022-08-30 | peildatum ligt op datum opschorting bijhouding   |
    | E                            | emigratie                      | 2022-09-01 | 2022-09-01 tot 2022-09-02 | peildatum ligt na datum opschorting bijhouding   |
    | M                            | ministerieel besluit           | 2022-08-28 | 2022-08-28 tot 2022-08-29 | peildatum ligt vóór datum opschorting bijhouding |
    | M                            | ministerieel besluit           | 2022-08-29 | 2022-08-29 tot 2022-08-30 | peildatum ligt op datum opschorting bijhouding   |
    | M                            | ministerieel besluit           | 2022-09-01 | 2022-09-01 tot 2022-09-02 | peildatum ligt na datum opschorting bijhouding   |
    | R                            | pl is aangelegd in de rni      | 2022-08-28 | 2022-08-28 tot 2022-08-29 | peildatum ligt vóór datum opschorting bijhouding |
    | R                            | pl is aangelegd in de rni      | 2022-08-29 | 2022-08-29 tot 2022-08-30 | peildatum ligt op datum opschorting bijhouding   |
    | R                            | pl is aangelegd in de rni      | 2022-09-01 | 2022-09-01 tot 2022-09-02 | peildatum ligt na datum opschorting bijhouding   |
    | .                            | onbekend                       | 2022-08-28 | 2022-08-28 tot 2022-08-29 | peildatum ligt vóór datum opschorting bijhouding |
    | .                            | onbekend                       | 2022-08-29 | 2022-08-29 tot 2022-08-30 | peildatum ligt op datum opschorting bijhouding   |
    | .                            | onbekend                       | 2022-09-01 | 2022-09-01 tot 2022-09-02 | peildatum ligt na datum opschorting bijhouding   |
