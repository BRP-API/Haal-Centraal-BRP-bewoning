#language: nl

@gba
Functionaliteit: raadpleeg bewoning met infrastructurele of technische wijziging

  Rule: een verblijfplaats met Aangifte adreshouding (72.10) met waarde "W" of "T" is dezelfde bewoning als de daaraan voorafgaande verblijfplaats van de persoon
      - hierbij geldt de datum aanvang adreshouding van de voorafgaande verblijfplaats

    Abstract Scenario: bewoner van hernummerd verblijfsobject
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200022197002                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode nummeraanduiding (11.90)' '0800200010877001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode nummeraanduiding (11.90)' '0800200022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010011067001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | type                             | Bewoning         |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010011067001 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                        |
      | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum ligt  na de hernummering  |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum ligt voor de hernummering |

    Abstract Scenario: adres is na gemeentelijke herindeling in andere gemeente komen liggen
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0123                 | 0123010011067001                         | 0123200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0123010011067001                         | 0123200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'gemeentecode (92.10)' '0123' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0123                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'gemeentecode (92.10)' '0800' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 0800                              | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0123010011067001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0123010011067001 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                                     |
      | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum ligt na de gemeentelijke herindeling   |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum ligt voor de gemeentelijke herindeling |


  Rule: van een adres zonder adresseerbaar object identificatie is de bewoning onbekend

    Abstract Scenario: BAG identificaties zijn toegevoegd voor de peildatum
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Spui               |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'straatnaam (11.10)' 'Spui' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | T                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010011067001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | type                             | Bewoning         |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010011067001 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                                                             |
      | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum ligt na de technische wijziging (toevoegen BAG identificaties) |
      | 2022-05-01 | 2022-05-01 tot 2022-05-02 | peildatum is de dag van de technische wijziging                          |

    Abstract Scenario: op de peildatum zijn er nog geen BAG identificaties bekend
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | straatnaam (11.10) |
      | 0800                 | Spui               |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'straatnaam (11.10)' 'Spui' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | T                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010011067001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                       | waarde                                        |
      | type                       | BewoningOnbekend                              |
      | periode                    | <periode>                                     |

      Voorbeelden:
      | peildatum  | periode                   | omschrijving                                                                       |
      | 2022-04-30 | 2022-04-30 tot 2022-05-01 | peildatum is de dag voor de de technische wijziging (toevoegen BAG identificaties) |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum ligt voor de technische wijziging                                        |
    

  Rule: bij een verblijfplaats met Aangifte adreshouding (72.10) met waarde "W" of "T" wordt de bewoning geleverd van het adresseerbaar object dat geldig was op de peildatum

    Abstract Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het samenvoegen van verblijfsobjecten
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                       |
      | type                             | BewoningMetPeildatum         |
      | peildatum                        | <peildatum>                  |
      | adresseerbaarObjectIdentificatie | <vraag object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                          |
      | type                             | Bewoning                        |
      | periode                          | <periode>                       |
      | adresseerbaarObjectIdentificatie | <antwoord object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | vraag object identificatie | antwoord object identificatie | peildatum  | periode                   | omschrijving                                                                           |
      | 0800010011067001           | 0800010011067001              | 2022-01-01 | 2022-01-01 tot 2022-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum ligt voor de wijziging |
      | 0800010011067001           | 0800010022197002              | 2023-01-01 | 2023-01-01 tot 2023-01-02 | oorspronkelijke adresseerbaar object identificatie en peildatum ligt na de wijziging   |
      | 0800010022197002           | 0800010011067001              | 2022-01-01 | 2022-01-01 tot 2022-01-02 | actuele adresseerbaar object identificatie en peildatum ligt voor de wijziging         |
      | 0800010022197002           | 0800010022197002              | 2023-01-01 | 2023-01-01 tot 2023-01-02 | actuele adresseerbaar object identificatie en peildatum ligt na de wijziging           |

    Abstract Scenario: adresseerbaar object is samengevoegd waarbij de bewoners van de oorspronkelijke verblijfsobjecten zijn gaan samenwonen met vragen op peildatum na de wijziging en de <omschrijving>
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200022192682                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022192003                         | 0800200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220515                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2023-01-01                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2023-01-01 tot 2023-01-02 |
      | adresseerbaarObjectIdentificatie | 0800010022192003          |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000048           |

      Voorbeelden:
      | adresseerbaar object identificatie | omschrijving                                           |§

    Scenario: adresseerbaar object is samengevoegd waarbij de bewoners van de oorspronkelijke verblijfsobjecten zijn gaan samenwonen met vragen op peildatum vóór de samenvoeging met de nieuwe adresseerbaar object identificatie
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200022192682                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022192003                         | 0800200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220515                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-01-01           |
      | adresseerbaarObjectIdentificatie | 0800010022192003     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-01-01 tot 2022-01-02 |
      | adresseerbaarObjectIdentificatie | 0800010011067001          |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-01-01 tot 2022-01-02 |
      | adresseerbaarObjectIdentificatie | 0800010022197002          |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |
  
    Abstract Scenario: adresseerbaar object is samengevoegd waarbij de bewoners van de oorspronkelijke verblijfsobjecten zijn gaan samenwonen met vragen op peildatum voor de samenvoeging met de oorspronkelijke adresseerbaar object identificatie
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200022192682                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022192003                         | 0800200010877001                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220515                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2022-01-01                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                               |
      | type                             | Bewoning                             |
      | periode                          | 2022-01-01 tot 2022-01-02            |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer   |
      | <burgerservicenummer> |

      Voorbeelden:
      | adresseerbaar object identificatie | burgerservicenummer |
      | 0800010011067001                   | 000000024           |
      | 0800010022197002                   | 000000048           |

    Abstract Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het splitsen van verblijfsobjecten en peildatum ligt voor splitsing
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022192003                         | 0800200022192003                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde                               |
      | type                             | BewoningMetPeildatum                 |
      | peildatum                        | 2022-01-01                           |
      | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-01-02 |
      | adresseerbaarObjectIdentificatie | 0800010011067001          |
      En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      | 000000048           |

      Voorbeelden:
      | adresseerbaar object identificatie | omschrijving                                       |
      | 0800010011067001                   | oorspronkelijke adresseerbaar object identificatie |
      | 0800010022197002                   | nieuwe adresseerbaar object identificatie          |
      | 0800010022192003                   | nieuwe adresseerbaar object identificatie          |

    Abstract Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het splitsen van verblijfsobjecten en peildatum ligt na splitsing met de nieuwe adresseerbaar object identificatie
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022192003                         | 0800200022192682                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
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
      | 0800010022197002                   | 000000024           |
      | 0800010022192003                   | 000000048           |

    Scenario: adresseerbaar object identificatie is gewijzigd als gevolg van het splitsen van verblijfsobjecten en peildatum ligt na splitsing met de oorspronkelijke adresseerbaar object identificatie
      Gegeven een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010011067001                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022197002                         | 0800200010877001                           |
      En een adres heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
      | 0800                 | 0800010022192003                         | 0800200022192003                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022197002' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010011067001' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010022192003' met de volgende gegevens
      | datum aanvang adreshouding (10.30) | Aangifte adreshouding (72.10) |
      | 20220501                           | W                             |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2023-01-01           |
      | adresseerbaarObjectIdentificatie | 0800010011067001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2023-01-01 tot 2023-01-02 |
      | adresseerbaarObjectIdentificatie | 0800010022197002          |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2023-01-01 tot 2023-01-02 |
      | adresseerbaarObjectIdentificatie | 0800010022192003          |
      En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |
