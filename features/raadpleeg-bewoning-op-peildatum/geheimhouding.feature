#language: nl

Functionaliteit: geheimhouding leveren bij een bewoner

Rule: indicatie geheim waarde 0 wordt niet geleverd

  Scenario: een persoon die toestemming heeft gegeven voor het verstrekken van zijn gegevens aan derden, is ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000854789                         | 20160526                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
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

  Scenario: dag datum aanvang adreshouding van een persoon op de aangegeven adresseerbaar object is onbekend en peildatum valt in die maand en de persoon heeft toestemming gegeven voor het verstrekken van zijn gegevens aan derden
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100800                           |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000854789                         | 20160526                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde |
    | indicatie geheim (70.10) | 0      |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-18           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-18 tot 2010-08-19 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-18 tot 2010-08-19' een mogelijk bewoner met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: indicatie geheim met waarde hoger dan 0 wordt vertaald naar geheimhoudingPersoonsgegevens waarde true en ongevraagd meegeleverd

  Abstract Scenario: een persoon met indicatie geheim <waarde>, is ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000854789                         | 20160526                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
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
    | burgerservicenummer | geheimhoudingPersoonsgegevens |
    | 000000024           | true                          |

    Voorbeelden:
    | waarde |
    | 1      |
    | 2      |
    | 3      |
    | 4      |
    | 5      |
    | 6      |
    | 7      |

  Abstract Scenario: dag datum aanvang adreshouding van een persoon op de aangegeven adresseerbaar object is onbekend en peildatum valt in die maand en de persoon heeft indicatie geheim <waarde>
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100800                           |
    En de persoon heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000854789                         | 20160526                           |
    En de persoon heeft de volgende 'inschrijving' gegevens
    | naam                     | waarde   |
    | indicatie geheim (70.10) | <waarde> |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2010-08-18           |
    | adresseerbaarObjectIdentificatie | 0518010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2010-08-18 tot 2010-08-19 |
    | adresseerbaarObjectIdentificatie | 0518010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2010-08-18 tot 2010-08-19' een mogelijk bewoner met de volgende gegevens
    | burgerservicenummer | geheimhoudingPersoonsgegevens |
    | 000000024           | true                          |

    Voorbeelden:
    | waarde |
    | 1      |
    | 2      |
    | 3      |
    | 4      |
    | 5      |
    | 6      |
    | 7      |
