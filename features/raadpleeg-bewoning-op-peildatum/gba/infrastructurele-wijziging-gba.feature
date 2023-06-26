#language: nl

@gba
Functionaliteit: raadpleeg bewoning met infrastructurele of technische wijziging

  Rule: een verblijfplaats met Aangifte adreshouding (72.10) met waarde "W" of "T" is dezelfde bewoning als de daaraan voorafgaande verblijfplaats van de persoon
      - hierbij geldt de datum aanvang adreshouding van de voorafgaande verblijfplaats
      - hierbij wordt de bewoning geleverd die geldt/gold op de peildatum

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
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'gemeentecode (92.10)' '1084' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 1084                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'gemeentecode (92.10)' '0014' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 0014                              | 20220501                           | W                             |
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
      | naam                             | waarde                       |
      | type                             | BewoningMetPeildatum         |
      | peildatum                        | <peildatum>                  |
      | adresseerbaarObjectIdentificatie | <vraag object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                          |
      | periode                          | <periode>                       |
      | adresseerbaarObjectIdentificatie | <antwoord object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | vraag object identificatie | antwoord object identificatie | peildatum  | periode                   | omschrijving                                                                      |
      | 1084010011067299           | 1084010011067299              | 2022-01-01 | 2022-01-01 tot 2022-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum voor de wijziging |
      | 1084010011067299           | 1084010022197986              | 2023-01-01 | 2023-01-01 tot 2023-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum na de wijziging   |
      | 1084010022197986           | 1084010011067299              | 2022-01-01 | 2022-01-01 tot 2022-01-02 | actuele adresseerbaar object identificatie en peildatum voor de wijziging         |
      | 1084010022197986           | 1084010022197986              | 2023-01-01 | 2023-01-01 tot 2023-01-02 | actuele adresseerbaar object identificatie en peildatum na de wijziging           |

    Abstract Scenario: adresseerbaar object is samengevoegd waarbij de bewoners van de oorspronkelijke verblijfsobjecten zijn gaan samenwonen met vragen op peildatum na de wijziging en de <omschrijving>
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022192681                         | 1084200022192682                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022192681' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220515                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2023-01-01                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2023-01-01 tot 2023-01-02 |
      | adresseerbaarObjectIdentificatie | 1084010022197986          |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000048           |

      Voorbeelden:
      | adresseerbaar object identificatie | omschrijving                                       |
      | 1084010011067299                   | oorspronkelijke adresseerbaar object identificatie |
      | 1084010022197986                   | actuele adresseerbaar object identificatie         |

    Scenario: adresseerbaar object is samengevoegd waarbij de bewoners van de oorspronkelijke verblijfsobjecten zijn gaan samenwonen met vragen op peildatum vóór de samenvoeging met de nieuwe adresseerbaar object identificatie
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022192681                         | 1084200022192682                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022192681' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220515                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 1084010022197986     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-01-02 |
      | adresseerbaarObjectIdentificatie | 1084010011067299          |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-01-02 |
      | adresseerbaarObjectIdentificatie | 1084010022192681          |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |

      Voorbeelden:
      | vraag object identificatie | antwoord object identificatie | bewoner | peildatum  | periode                   | omschrijving                                                                      |
      | 1084010011067299           | 1084010011067299              | 2022-01-01 | 2022-01-01 tot 2022-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum voor de wijziging |
      | 1084010022197986           | 1084010011067299              | 2022-01-01 | 2022-01-01 tot 2022-01-02 | actuele adresseerbaar object identificatie en peildatum voor de wijziging         |
  
    Abstract Scenario: adresseerbaar object is samengevoegd waarbij de bewoners van de oorspronkelijke verblijfsobjecten zijn gaan samenwonen met vragen op peildatum voor de samenvoeging met de oorspronkelijke adresseerbaar object identificatie
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022192681                         | 1084200022192682                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022192681' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220515                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2022-01-01                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                               |
      | periode                          | 2022-01-01 tot 2022-01-02            |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer   |
      | <burgerservicenummer> |

      Voorbeelden:
      | adresseerbaar object identificatie | burgerservicenummer |
      | 1084010011067299                   | 000000024           |
      | 1084010022192681                   | 000000048           |

    Abstract Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het splitsen van verblijfsobjecten en peildatum ligt voor splitsing
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022192681                         | 1084200022192682                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022192681' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2022-01-01                          |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                               |
      | periode                          | 2022-01-01 tot 2022-01-02            |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000048           |

      Voorbeelden:
      | adresseerbaar object identificatie |
      | 1084010011067299                   |
      | 1084010022197986                   |
      | 1084010022192681                   |

    Abstract Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het splitsen van verblijfsobjecten en peildatum ligt na splitsing
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022192681                         | 1084200022192682                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022192681' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2023-01-01                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                               |
      | periode                          | 2023-01-01 tot 2023-01-02            |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
      | burgerservicenummer   |
      | <burgerservicenummer> |

      Voorbeelden:
      | adresseerbaar object identificatie | burgerservicenummer |
      | 1084010022197986                   | 000000024           |
      | 1084010022192681                   | 000000048           |

  Rule: bij bepalen van bewoning wordt niet gekeken of de volgende verblijfplaats Aangifte adreshouding (72.10) de waarde "W" of "T" heeft

    Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het samenvoegen van verblijfsobjecten en bewoning van het oorspronkelijke adresseerbaar object wordt gevraagd op een peildatum na de wijziging
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
      | peildatum                        | 2023-01-01                          |
      | adresseerbaarObjectIdentificatie | 1084010011067299 |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                               |
      | periode                          | 2023-01-01 tot 2023-01-02                            |
      | adresseerbaarObjectIdentificatie | 1084010011067299 |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' geen bewoners

    Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het splitsen van verblijfsobjecten en peildatum ligt na splitsing en vragen verblijfsobject dat dan niet meer bestaat
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010011067299                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022197986                         | 1084200010877405                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 1084                 | 1084010022192681                         | 1084200022192682                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022197986' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010011067299' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '1084010022192681' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2023-01-01                           |
      | adresseerbaarObjectIdentificatie | 1084010011067299 |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2023-01-01 tot 2023-01-02 |
      | adresseerbaarObjectIdentificatie | 1084010011067299          |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' geen bewoners
