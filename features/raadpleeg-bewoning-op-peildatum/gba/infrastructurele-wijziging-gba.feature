#language: nl

@gba
Functionaliteit: raadpleeg bewoning met infrastructurele of technische wijziging

    Abstract Scenario: bewoner van hernummerd verblijfsobject
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200022197986                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode nummeraanduiding (11.90)' '1084200010877405' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode nummeraanduiding (11.90)' '1084200022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 1084010011067299     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 1084010011067299 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                   |
      | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum na de hernummering   |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum voor de hernummering |

    Abstract Scenario: BAG identificaties zijn toegevoegd tijdens de bewoning
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 1084                 | Spui               |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200022197986                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'straatnaam (11.10)' 'Spui' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | T                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 1084010011067299     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 1084010011067299 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                                                        |
      | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum na de technische wijziging (toevoegen BAG identificaties) |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum voor de technische wijziging                              |

    Abstract Scenario: adres is na gemeentelijke herindeling in andere gemeente komen liggen
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0014                 | 1084010011067299                         | 1084200010877405                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode nummeraanduiding (11.90)' '1084200010877405' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode nummeraanduiding (11.90)' '1084200022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 1084010011067299     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 1084010011067299 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                                |
      | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum na de gemeentelijke herindeling   |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum voor de gemeentelijke herindeling |

    Abstract Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het samenvoegen van verblijfsobjecten
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | <peildatum>                          |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                               |
      | periode                          | <periode>                            |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | adresseerbaar object identificatie | peildatum  | periode                   | omschrijving                                                                      |
      | 1084010011067299                   | 2023-01-01 | 2023-01-01 tot 2023-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum na de wijziging   |
      | 1084010011067299                   | 2022-01-01 | 2022-01-01 tot 2022-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum voor de wijziging |
      | 1084010022197986                   | 2023-01-01 | 2023-01-01 tot 2023-01-02 | actuele adresseerbaar object identificatie en peildatum na de wijziging           |
      | 1084010022197986                   | 2022-01-01 | 2022-01-01 tot 2022-01-02 | actuele adresseerbaar object identificatie en peildatum voor de wijziging         |
