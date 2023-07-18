#language: nl

Functionaliteit: leveren indicatie veel bewoners

  Als afnemer
  Wil ik een indicatie wanneer op de gevraagde adresseerbaar object en peildatum meer dan 100 inschrijvingen zijn
  Zodat ik dit kan onderzoeken


Rule: indicatieVeelBewoners wordt geleverd wanneer er op een peildatum meer dan 100 bewoners zijn

  Scenario: adresseerbaar object heeft op de gevraagde peildatum 101 bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En er zijn 101 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2020-08-18 tot 2020-08-19 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-08-18 tot 2020-08-19' geen bewoners
    En heeft de bewoningPeriode de volgende gegevens
    | naam                  | waarde |
    | indicatieVeelBewoners | true   |

  Scenario: adresseerbaar object heeft op de gevraagde peildatum 101 mogelijke bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En er zijn 101 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2020-08-18 tot 2020-08-19 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-08-18 tot 2020-08-19' geen bewoners
    En heeft de bewoningPeriode de volgende gegevens
    | naam                  | waarde |
    | indicatieVeelBewoners | true   |

  Scenario: adresseerbaar object heeft op de gevraagde peildatum in totaal 101 bewoners en mogelijke bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En er zijn 81 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    En er zijn 20 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2020-08-18 tot 2020-08-19 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-08-18 tot 2020-08-19' geen bewoners
    En heeft de bewoningPeriode de volgende gegevens
    | naam                  | waarde |
    | indicatieVeelBewoners | true   |

  Scenario: adresseerbaar object heeft op de gevraagde peildatum 100 bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En er zijn 100 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met een bewoningPeriode '2020-08-18 tot 2020-08-19' met 100 bewoners

  Scenario: adresseerbaar object heeft op de gevraagde peildatum in totaal 100 bewoners en mogelijke bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En er zijn 80 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    En er zijn 20 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met een bewoningPeriode '2020-08-18 tot 2020-08-19' met 80 bewoners
    En heeft de response een bewoning met een bewoningPeriode '2020-08-18 tot 2020-08-19' met 20 mogelijke bewoners
