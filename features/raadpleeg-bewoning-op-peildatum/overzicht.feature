#language: nl

Functionaliteit: raadpleeg bewoning op peildatum

Rule: een persoon is bewoner van een verblijfplaats op een peildatum als:
      - de peildatum valt na de datum aanvang adreshouding van de persoon op de verblijfplaats en
      - de peildatum valt voor de datum aanvang adreshouding van de persoon op zijn volgende verblijfplaats

  Abstract Scenario: er is één persoon ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    | 0518010000854789                         | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                   |
    | type                             | MedebewonersMetPeildatum |
    | peildatum                        | <peildatum>              |
    | adresseerbaarObjectIdentificatie | 0518010000713450         |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '<periode>' de volgende bewoners
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   |
    | 2010-09-01 | 2010-09-01 tot 2010-09-02 |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 |
    | 2016-05-25 | 2016-05-25 tot 2016-05-26 |

  Abstract Scenario: er zijn geen personen ingeschreven op het aangegeven adresseerbaar object en peildatum
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    | 0518010000854789                         | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                   |
    | type                             | MedebewonersMetPeildatum |
    | peildatum                        | <peildatum>              |
    | adresseerbaarObjectIdentificatie | 0518010000713450         |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '<periode>' geen bewoners

    Voorbeelden:
    | peildatum  | periode                   |
    | 2010-08-17 | 2010-08-17 tot 2010-08-18 |
    | 2016-05-26 | 2016-05-26 tot 2016-05-27 |

Rule: bij onbekende dag in de datum aanvang adreshouding van een persoon op een adresseerbaar object, wordt die hele maand meegenomen als mogelijke bewoning van de betreffende persoon

  Abstract Scenario: dag datum aanvang adreshouding van een persoon op de aangegeven adresseerbaar object is onbekend en peildatum valt in die maand
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100800                           |
    | 0518010000854789                         | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                   |
    | type                             | MedebewonersMetPeildatum |
    | peildatum                        | <peildatum>              |
    | adresseerbaarObjectIdentificatie | 0518010000713450         |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '<periode>' de volgende mogelijke bewoners
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   |
    | 2010-08-01 | 2010-08-01 tot 2010-08-02 |
    | 2010-08-18 | 2010-08-18 tot 2010-08-19 |
    | 2010-08-31 | 2010-08-31 tot 2010-09-01 |

  Abstract Scenario: dag datum aanvang adreshouding van een persoon op zijn volgend verblijfplaats is onbekend en peildatum valt in die maand
    Gegeven de persoon met burgerservicenummer '000000024' heeft de volgende 'verblijfplaats' gegevens
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    | 0518010000854789                         | 20160500                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                   |
    | type                             | MedebewonersMetPeildatum |
    | peildatum                        | <peildatum>              |
    | adresseerbaarObjectIdentificatie | 0518010000713450         |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '<periode>' de volgende mogelijke bewoners
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   |
    | 2016-05-01 | 2016-05-01 tot 2016-05-02 |
    | 2016-05-18 | 2016-05-18 tot 2016-05-19 |
    | 2016-05-31 | 2016-05-31 tot 2016-06-01 |
