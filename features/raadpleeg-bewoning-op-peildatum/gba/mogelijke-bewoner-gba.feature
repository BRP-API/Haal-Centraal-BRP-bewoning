#language: nl

@gba
Functionaliteit: mogelijke bewoner bij onzekere begin- of einddatum van het verblijf

  Achtergrond:
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000747448                         |
    En een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000713450                         |
    En een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0518                 | 0518010000854789                         |


  Rule: een persoon is geen (mogelijke) bewoner bij onbekende datum aanvang van verblijf als de peildatum op of voor de datum aanvang van het vorige verblijf ligt

    Abstract Scenario: peildatum is gelijk aan datum aanvang adreshouding vorige verblijf en datum aanvang huidig verblijf <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000747448' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220803                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-03           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-08-03 tot 2022-08-04 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-03 tot 2022-08-04' geen bewoners

      Voorbeelden:
      | datum aanvang | scenario                                     |
      | 20220800      | in dezelfde maand met onbekende dag          |
      | 20220000      | in hetzelfde jaar met onbekende maand en dag |
      | 00000000      | is volledig onbekend                         |

    Abstract Scenario: peildatum is dag na datum aanvang adreshouding vorige verblijf en datum aanvang huidig verblijf <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000747448' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220803                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-04           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-08-04 tot 2022-08-05 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-04 tot 2022-08-05' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | scenario                                     |
      | 20220800      | in dezelfde maand met onbekende dag          |
      | 20220000      | in hetzelfde jaar met onbekende maand en dag |
      | 00000000      | is volledig onbekend                         |

    Scenario: peildatum is 1e dag van maand en aanvang vorige verblijf ligt in vorige maand
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000747448' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220731                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-04           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-08-04 tot 2022-08-05 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-04 tot 2022-08-05' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |


  Rule: een persoon is geen (mogelijke) bewoner van een adresseerbaar object wanneer de datum aanvang onbekend is, maar de peildatum ligt na de datum aanvang van een volgend verblijf

    Abstract Scenario: peildatum is gelijk aan datum aanvang adreshouding volgend verblijf en datum aanvang huidig verblijf <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220803                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-03           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-08-03 tot 2022-08-04 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-03 tot 2022-08-04' geen bewoners

      Voorbeelden:
      | datum aanvang | scenario                                     |
      | 20220800      | in dezelfde maand met onbekende dag          |
      | 20220000      | in hetzelfde jaar met onbekende maand en dag |
      | 00000000      | is volledig onbekend                         |

    Abstract Scenario: peildatum is dag voor datum aanvang adreshouding volgend verblijf en datum aanvang huidig verblijf <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220805                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-04           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-08-04 tot 2022-08-05 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-04 tot 2022-08-05' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | scenario                                     |
      | 20220800      | in dezelfde maand met onbekende dag          |
      | 20220000      | in hetzelfde jaar met onbekende maand en dag |
      | 00000000      | is volledig onbekend                         |

    Abstract Scenario: peildatum is de dag voor de laatste dag van datum aanvang en de dag voor de laatste dag van aanvang volgende verblijf 
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang volgende>           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-12-30           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-12-30 tot 2022-12-31 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-12-30 tot 2022-12-31' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | datum aanvang volgende |
      | 20221200      | 20221200               |
      | 20221200      | 20220000               | 
      | 20221200      | 00000000               | 
      | 20220000      | 20221200               | 
      | 20220000      | 20220000               | 
      | 20220000      | 00000000               | 
      | 00000000      | 20221200               | 
      | 00000000      | 20220000               | 
      | 00000000      | 00000000               | 
    
    Abstract Scenario: peildatum is de laatste dag van datum aanvang en de laatste dag van aanvang volgende verblijf 
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang volgende>           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-12-31           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | type                             | Bewoning                  |
      | periode                          | 2022-12-31 tot 2023-01-01 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-03 tot 2022-08-04' geen bewoners

      Voorbeelden:
      | datum aanvang | datum aanvang volgende |
      | 20221200      | 20221200               |
      | 20221200      | 20220000               | 
      | 20221200      | 00000000               | 
      | 20220000      | 20221200               | 
      | 20220000      | 20220000               | 
      | 20220000      | 00000000               | 
      | 00000000      | 20221200               | 
      | 00000000      | 20220000               | 
      | 00000000      | 00000000               | 
