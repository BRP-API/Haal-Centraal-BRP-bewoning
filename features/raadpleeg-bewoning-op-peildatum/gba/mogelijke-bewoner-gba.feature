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


  Rule: een persoon is geen (mogelijke) bewoner bij onbekende datum aanvang van verblijf als de peildatum op of vóór de datum aanvang van het vorige verblijf ligt

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
      | periode                          | 2022-08-03 tot 2022-08-04 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-03 tot 2022-08-04' geen bewoners

      Voorbeelden:
      | datum aanvang | scenario                                        |
      | 20220800      | is in dezelfde maand met onbekende dag          |
      | 20220000      | is in hetzelfde jaar met onbekende maand en dag |
      | 00000000      | is volledig onbekend                            |

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
      | periode                          | 2022-08-04 tot 2022-08-05 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-04 tot 2022-08-05' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | scenario                                        |
      | 20220800      | is in dezelfde maand met onbekende dag          |
      | 20220000      | is in hetzelfde jaar met onbekende maand en dag |
      | 00000000      | is volledig onbekend                            |

    Scenario: peildatum is 1e dag van maand datum aanvang en de aanvang van het vorige verblijf ligt in vorige maand
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000747448' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220731                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-01           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-08-01 tot 2022-08-02 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-01 tot 2022-08-02' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |


  Rule: een persoon is geen (mogelijke) bewoner van een adresseerbaar object wanneer de datum aanvang onbekend is, maar de peildatum ligt op of na de datum aanvang van een volgend verblijf

    Abstract Scenario: peildatum is gelijk aan de datum aanvang van de volgende verblijfplaats en ligt binnen de periode van een (gedeeltelijk) onbekende datum aanvang van de gevraagde verblijfplaats
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
      | periode                          | 2022-08-03 tot 2022-08-04 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-03 tot 2022-08-04' geen bewoners

      Voorbeelden:
      | datum aanvang | omschrijving                                                                                                                        |
      | 20220800      | aanvang volgende verblijfplaats ligt in dezelfde maand als datum aanvang van de gevraagde verblijfplaats met onbekende dag          |
      | 20220000      | aanvang volgende verblijfplaats ligt in hetzelfde jaar als datum aanvang van de gevraagde verblijfplaats met onbekende maand en dag |
      | 00000000      | datum aanvang de gevraagde verblijfplaats is volledig onbekend                                                                      |

    Abstract Scenario: peildatum is de dag vóór de datum aanvang van de volgende verblijfplaats en ligt binnen de periode van een (gedeeltelijk) onbekende datum aanvang van de gevraagde verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.03) |
      | 20220803                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-02           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-08-02 tot 2022-08-03 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2022-08-02 tot 2022-08-03' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | omschrijving                                                                                                                        |
      | 20220800      | aanvang volgende verblijfplaats ligt in dezelfde maand als datum aanvang van de gevraagde verblijfplaats met onbekende dag          |
      | 20220000      | aanvang volgende verblijfplaats ligt in hetzelfde jaar als datum aanvang van de gevraagde verblijfplaats met onbekende maand en dag |
      | 00000000      | datum aanvang de gevraagde verblijfplaats is volledig onbekend                                                                      |


  Rule: een persoon is mogelijk bewoner van een adresseerbaar object op een peildatum binnen de onzekerheidsperiode van de datum aanvang als:
        - datum aanvang gevraagde verblijfplaats én datum aanvang volgende verblijfplaats beide (gedeeltelijk) onbekend zijn 
        - EN datum aanvang gevraagde verblijfplaats én datum aanvang volgende verblijfplaats gelijk aan elkaar zijn

    ![zelfde-periode](illustraties/zelfde-periode.svg)

    Abstract Scenario: datum aanvang gevraagde verblijfplaats en datum aanvang volgende verblijfplaats zijn en gelijk aan elkaar met alleen jaar en maand bekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                           |
      | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding                |
      | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats en datum aanvang volgende verblijfplaats zijn en gelijk aan elkaar met alleen jaar en maand bekend en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                            |
      | 2010-07-31 | 2010-07-31 tot 2010-08-01 | peildatum valt op de laatste dag vóór de maand aanvang adreshouding |
      | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt op de eerste dag na de maand aanvang adreshouding    |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats en datum aanvang volgende verblijfplaats zijn en gelijk aan elkaar met alleen jaar is bekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                           |
      | 2010-01-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van het jaar aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen het jaar aanvang adreshouding                |
      | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum valt op de laatste dag van het jaar aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats en datum aanvang volgende verblijfplaats zijn en gelijk aan elkaar met alleen jaar is bekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                            |
      | 2009-12-31 | 2009-12-31 tot 2010-01-01 | peildatum valt op de laatste dag vóór het jaar aanvang adreshouding |
      | 2011-01-01 | 2011-01-01 tot 2011-01-02 | peildatum valt op de eerste dag na het jaar aanvang adreshouding    |

    Scenario: datum aanvang gevraagde verblijfplaats en datum aanvang volgende verblijfplaats zijn beide volledig onbekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2010-08-18           |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-08-01 tot 2010-08-02 |
      | adresseerbaarObjectIdentificatie | 0518010000713450          |
      En heeft de bewoning voor de bewoningPeriode '2010-08-01 tot 2010-08-02' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |


  Rule: een persoon is mogelijk bewoner van een adresseerbaar object op een peildatum binnen de onzekerheidsperiode van de datum aanvang van de volgende verblijfplaats als:
        - datum aanvang gevraagde verblijfplaats én datum aanvang volgende verblijfplaats beide (gedeeltelijk) onbekend zijn 
        - EN de onzekerheidsperiode van de volgende verblijfplaats geheel binnen de onzekerheidsperiode van de gevraagde verblijfplaats valt

    ![binnen-vorige](illustraties/binnen-vorige.svg)

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar bekend en datum aanvang volgende verblijfplaats zijn alleen jaar en maand bekend en beide hebben zelfde jaar
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                   |
      | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding volgende verblijfplaats  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding volgende verblijfplaats                |
      | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding volgende verblijfplaats |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar bekend en datum aanvang volgende verblijfplaats zijn alleen jaar en maand bekend en beide hebben zelfde jaar en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                 |
      | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt op de eerste dag na de maand aanvang adreshouding volgende verblijfplaats |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is volledig onbekend en datum aanvang volgende verblijfplaats is alleen jaar en maand bekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                           |
      | 2010-01-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding                |
      | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is volledig onbekend en datum aanvang volgende verblijfplaats is alleen jaar en maand bekend en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                 |
      | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt op de eerste dag na de maand aanvang adreshouding volgende verblijfplaats |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is volledig onbekend en datum aanvang volgende verblijfplaats is alleen jaar bekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                           |
      | 2010-01-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van het jaar aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen het jaar aanvang adreshouding                |
      | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum valt op de laatste dag van het jaar aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is volledig onbekend en datum aanvang volgende verblijfplaats is alleen jaar en maand bekend en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                |
      | 2011-01-01 | 2011-01-01 tot 2011-01-02 | peildatum valt op de eerste dag na de jaar aanvang adreshouding volgende verblijfplaats |


  Rule: een persoon is mogelijk bewoner van een adresseerbaar object op een peildatum binnen de onzekerheidsperiode van de datum aanvang van de gevraagde verblijfplaats als:
    - datum aanvang gevraagde verblijfplaats én datum aanvang volgende verblijfplaats beide (gedeeltelijk) onbekend zijn
    - EN de onzekerheidsperiode van de gevraagde verblijfplaats geheel binnen de onzekerheidsperiode van de volgende verblijfplaats valt
      
    ![binnen-volgende](illustraties/binnen-volgende.svg)

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar en maand bekend en datum aanvang volgende verblijfplaats is alleen jaar en beide hebben zelfde jaar
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                   |
      | 2010-08-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding                |
      | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar en maand bekend en datum aanvang volgende verblijfplaats is alleen jaar en beide hebben zelfde jaar en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                         |
      | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt op de eerste dag na de maand aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar en maand bekend en datum aanvang volgende verblijfplaats is volledig onbekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                           |
      | 2010-01-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van de maand aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen de maand aanvang adreshouding                |
      | 2010-08-31 | 2010-08-31 tot 2010-09-01 | peildatum valt op de laatste dag van de maand aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar en maand bekend en datum aanvang volgende verblijfplaats is volledig onbekend en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100800                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                         |
      | 2010-09-01 | 2010-09-01 tot 2010-09-02 | peildatum valt op de eerste dag na de maand aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar bekend en datum aanvang volgende verblijfplaats is volledig onbekend
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                           |
      | 2010-01-01 | 2010-08-01 tot 2010-08-02 | peildatum valt op de eerste dag van het jaar aanvang adreshouding  |
      | 2010-08-18 | 2010-08-18 tot 2010-08-19 | peildatum valt binnen het jaar aanvang adreshouding                |
      | 2010-12-31 | 2010-12-31 tot 2011-01-01 | peildatum valt op de laatste dag van het jaar aanvang adreshouding |

    Abstract Scenario: datum aanvang gevraagde verblijfplaats is alleen jaar bekend en datum aanvang volgende verblijfplaats is volledig onbekend en peildatum ligt buiten de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000713450' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100000                           |
      En de persoon is vervolgens ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0518010000854789' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 00000000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0518010000713450     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0518010000713450 |
      En heeft de bewoning voor de bewoningPeriode '<periode>' geen bewoners

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                       |
      | 2011-01-01 | 2011-01-01 tot 2011-01-02 | peildatum valt op de eerste dag na de jaar aanvang adreshouding verblijfplaats |
