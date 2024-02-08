#language: nl

Functionaliteit: 'indicatie vastgesteld verblijft niet op adres' in combinatie met onbekende datums bij bewoning met periode

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |


    Abstract Scenario: <soort datum> aanvang en 'vastgesteld verblijft niet op adres' begint <begin onderzoek>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | soort datum                                 | begin onderzoek        | periode                   |
      | 20220500      | gedeeltelijk onbekende (maand + jaar) datum | in onzekerheidsperiode | 2022-05-01 tot 2022-05-26 |
      | 20220000      | gedeeltelijk onbekende (alleen jaar) datum  | in onzekerheidsperiode | 2022-01-01 tot 2022-05-26 |
      | 00000000      | volledig onbekende datum                    | in onzekerheidsperiode | 2021-01-01 tot 2022-05-26 |
      | 20220400      | gedeeltelijk onbekende (maand + jaar) datum | na onzekerheidsperiode | 2022-04-01 tot 2022-05-26 |
      | 20210000      | gedeeltelijk onbekende (alleen jaar) datum  | na onzekerheidsperiode | 2021-01-01 tot 2022-05-26 |

    Abstract Scenario: <soort datum> aanvang volgende verblijf en 'vastgesteld verblijft niet op adres' begint <begin onderzoek>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | <datum aanvang volgende>               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang volgende | soort datum                                 | begin onderzoek          | periode                   |
      | 20220600               | gedeeltelijk onbekende (maand + jaar) datum | voor onzekerheidsperiode | 2020-08-18 tot 2022-05-26 |
      | 20230000               | gedeeltelijk onbekende (alleen jaar) datum  | voor onzekerheidsperiode | 2020-08-18 tot 2022-05-26 |
      | 20220500               | gedeeltelijk onbekende (maand + jaar) datum | in onzekerheidsperiode   | 2020-08-18 tot 2022-05-26 |
      | 20220000               | gedeeltelijk onbekende (alleen jaar) datum  | in onzekerheidsperiode   | 2020-08-18 tot 2022-05-26 |
      | 00000000               | volledig onbekende datum                    | in onzekerheidsperiode   | 2020-08-18 tot 2022-05-26 |
      | 20220417               | bekende datum                               | na onzekerheidsperiode   | 2020-08-18 tot 2022-04-17 |
      | 20220400               | gedeeltelijk onbekende (maand + jaar) datum | na onzekerheidsperiode   | 2020-08-18 tot 2022-05-01 |
      | 20210000               | gedeeltelijk onbekende (alleen jaar) datum  | na onzekerheidsperiode   | 2020-08-18 tot 2022-01-01 |

    Abstract Scenario: <soort datum volgende> aanvang volgende verblijf en 'vastgesteld verblijft niet op adres' begint <begin onderzoek> en eindigt <eind onderzoek>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | <datum ingang onderzoek>       | <datum einde onderzoek>       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | <datum aanvang volgende>               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2024-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang volgende | soort datum volgende                        | datum ingang onderzoek | begin onderzoek          | datum einde onderzoek | eind onderzoek         | periode                   |
      | 20220500               | gedeeltelijk onbekende (maand + jaar) datum | 20211014               | voor onzekerheidsperiode | 20220526              | in onzekerheidsperiode | 2020-08-18 tot 2022-06-01 |
      | 20220000               | gedeeltelijk onbekende (alleen jaar) datum  | 20211014               | voor onzekerheidsperiode | 20220526              | in onzekerheidsperiode | 2020-08-18 tot 2023-01-01 |
      | 20220500               | gedeeltelijk onbekende (maand + jaar) datum | 20220516               | in onzekerheidsperiode   | 20220526              | in onzekerheidsperiode | 2020-08-18 tot 2022-06-01 |
      | 20220000               | gedeeltelijk onbekende (alleen jaar) datum  | 20220516               | in onzekerheidsperiode   | 20220526              | in onzekerheidsperiode | 2020-08-18 tot 2023-01-01 |
      | 00000000               | volledig onbekende datum                    | 20211014               | in onzekerheidsperiode   | 20220526              | in onzekerheidsperiode | 2020-08-18 tot 2024-01-01 |
      | 20220500               | gedeeltelijk onbekende (maand + jaar) datum | 20220516               | in onzekerheidsperiode   | 20231014              | na onzekerheidsperiode | 2020-08-18 tot 2022-06-01 |
      | 20220000               | gedeeltelijk onbekende (alleen jaar) datum  | 20220516               | in onzekerheidsperiode   | 20231014              | na onzekerheidsperiode | 2020-08-18 tot 2023-01-01 |
      | 20220500               | gedeeltelijk onbekende (maand + jaar) datum | 20230730               | na onzekerheidsperiode   | 20231014              | na onzekerheidsperiode | 2020-08-18 tot 2022-06-01 |
      | 20220000               | gedeeltelijk onbekende (alleen jaar) datum  | 20230730               | na onzekerheidsperiode   | 20231014              | na onzekerheidsperiode | 2020-08-18 tot 2023-01-01 |

    Abstract Scenario: gedeeltelijk onbekende aanvang verblijf en gedeeltelijk onbekende aanvang volgende verblijf en 'vastgesteld verblijft niet op adres' begint <begin onderzoek> en eindigt <eind onderzoek>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | <datum ingang onderzoek>       | <datum einde onderzoek>       | 20210500                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220000                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2024-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-05-01 tot 2023-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum ingang onderzoek | begin onderzoek                 | datum einde onderzoek | eind onderzoek                  |
      | 20210516               | in onzekerheidsperiode aanvang  | 20221014              | in onzekerheidsperiode volgende |
      | 20210730               | tussen de onzekerheidsperiodes  | 20221014              | in onzekerheidsperiode volgende |
      | 20220526               | in onzekerheidsperiode volgende | 20221014              | in onzekerheidsperiode volgende |
      | 20210516               | in onzekerheidsperiode aanvang  | 20230210              | na onzekerheidsperiode volgende |
      | 20210730               | tussen de onzekerheidsperiodes  | 20230210              | na onzekerheidsperiode volgende |
      | 20220526               | in onzekerheidsperiode volgende | 20230210              | na onzekerheidsperiode volgende |
