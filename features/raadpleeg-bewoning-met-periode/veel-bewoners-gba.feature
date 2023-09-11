#language: nl

Functionaliteit: leveren indicatie veel bewoners bij het raadplegen van bewoning in periode

  Als afnemer
  Wil ik een indicatie wanneer op de gevraagde adresseerbaar object en periode meer dan 100 inschrijvingen zijn
  Zodat ik dit kan onderzoeken


Rule: indicatieVeelBewoners wordt geleverd wanneer er in een periode meer dan 100 bewoners zijn

  Scenario: adresseerbaar object heeft in de gevraagde periode 101 bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En er zijn 101 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-08-18         |
    | datumTot                         | 2021-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-08-18 tot 2021-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    | indicatieVeelBewoners            | true                      |
    En heeft de bewoning geen bewoners en geen mogelijke bewoners

  Scenario: adresseerbaar object heeft in de gevraagde periode 101 mogelijke bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En er zijn 101 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-08-18           |
    | datumTot                         | 2021-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-08-18 tot 2021-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    | indicatieVeelBewoners            | true                      |
    En heeft de bewoning geen bewoners en geen mogelijke bewoners

  Scenario: adresseerbaar object heeft in de gevraagde periode in totaal 101 bewoners en mogelijke bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En er zijn 81 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    En er zijn 20 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-08-18           |
    | datumTot                         | 2021-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-08-18 tot 2021-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    | indicatieVeelBewoners            | true                      |
    En heeft de bewoning geen bewoners en geen mogelijke bewoners

  Scenario: adresseerbaar object heeft in de gevraagde periode 100 bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En er zijn 100 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-08-18           |
    | datumTot                         | 2021-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met 100 bewoners en 0 mogelijke bewoners

  Scenario: adresseerbaar object heeft in de gevraagde periode in totaal 100 bewoners en mogelijke bewoners
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En er zijn 80 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200818                           |
    En er zijn 20 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20200800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2020-08-18           |
    | datumTot                         | 2021-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met 80 bewoners en 20 mogelijke bewoners
