#language: nl

Functionaliteit: bijzondere situaties 'indicatie vastgesteld verblijft niet op adres' bij bewoning met periode

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |


  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999'wordt niet geleverd als bewoner vanaf de ingangsdatum van het onderzoek

    # A1: |-----OOOO
    # A2:           ????----
    #     MMMMMM
    Abstract Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220600                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 0 bewoningen
      
      Voorbeelden:
      | datum van  | datum tot  | scenario                                                       |
      | 2022-06-03 | 2022-06-14 | periode ligt in de onzekerheidsperiode van volgende verblijf   |
      | 2022-06-23 | 2022-08-12 | periode begint in de onzekerheidsperiode van volgende verblijf |

    #A1: |----OOOO
    #VB:        ??----
    #    MMMMM
    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum en periode loopt tot in de onzekerheidsperiode van volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220700                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-06-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 0 bewoningen


  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999' wordt geleverd als mogelijke bewoner tot de ingangsdatum van het onderzoek

    # A1: ????OOOOO
    # A2:          |-----
    #     MMMM
    Abstract Scenario: persoon verblijft niet meer op het gevraagde adres en stond daar ingeschreven met <soort datum> aanvang en gevraagde periode overlapt de datum ingang onderzoek binnen de onzekerheidsperiode van datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-01         |
      | datumTot                         | 2022-06-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-01 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | soort datum                  |
      | 20220000      | gedeeltelijk onbekende datum |
      | 00000000      | volledig onbekende datum     |

    # A1: ????---OOOO
    #     MMMMMMM
    Abstract Scenario: persoon verblijft mogelijk nog op het gevraagde adres en stond daar ingeschreven met <soort datum> aanvang en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 089999                          | 20220526                       | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-04-05         |
      | datumTot                         | 2022-06-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-04-05 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | soort datum                  | scenario                                                                                        |
      | 20220400      | gedeeltelijk onbekende datum | periode overlapt de onzekerheidsperiode datum aanvang en datum ingang onderzoek                 |
      | 20220000      | gedeeltelijk onbekende datum | periode overlapt de datum ingang onderzoek die ligt in de onzekerheidsperiode van datum aanvang |
      | 00000000      | volledig onbekende datum     | periode overlapt de datum ingang onderzoek die ligt in de onzekerheidsperiode van datum aanvang |


    # A1: |----OOOO|----
    #     MMMMM    BBBBB
    Scenario: persoon verblijft niet meer op het gevraagde adres en staat daar nu weer wel ingeschreven
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2020-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2020-08-18 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-08-10 tot 2023-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    #A1P24: |----OOOO
    #A1P48:    |-----
    #P24:   MMMMM
    #P48:      BBBBBB
    #Bew.:  111223333
    Scenario: persoon verblijft niet meer op het gevraagde adres en andere persoon verblijft er wel
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 089999                          | 20220526                       | 20200818                           |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220401                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-04-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-04-01 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-26 tot 2023-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |

    #A1: |----OOOO
    #VB:        ??----
    #    MMMMM
    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum en periode loopt tot in de onzekerheidsperiode van volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220600                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    #A1: |----OOOO
    #VB:    ????----
    #    MMMMM
    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum die datum ingang onderzoek overlapt
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220500                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |


  Rule: een persoon met beëindigd onderzoek met aanduiding in onderzoek waarde '089999' op de actuele verblijfplaats wordt geleverd als bewoner
    # maar is wel mogelijke bewoner voor onzekerheidsperiode van datum aanvang

    Abstract Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '589999' en stond daar ingeschreven met <soort datum> aanvang en periode overlapt de datum ingang onderzoek die ligt in de onzekerheidsperiode van datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 089999                          | 20220526                       | 20221130                      | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-01         |
      | datumTot                         | 2022-06-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-05 tot 2022-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | soort datum                                  |
      | 20220500      | gedeeltelijk (jaar en maand) onbekende datum |
      | 20220000      | gedeeltelijk (jaar) onbekende datum          |
      | 00000000      | volledig onbekende datum                     |


  Rule: een persoon met onderzoek met aanduiding in onderzoek waarde '089999' of '589999' op een historische verblijfplaats en het onderzoek is beëindigd op of voor datum aanvang van de volgende verblijfplaats wordt geleverd als bewoner
    # maar is wel mogelijke bewoner voor onzekerheidsperiode van datum aanvang
    # en is wel mogelijke bewoner voor onzekerheidsperiode van datum aanvang volgende verblijf

    Abstract Scenario: onderzoek met aanduiding in onderzoek waarde '589999' is beëindigd op datum aanvang volgende verblijf en verblijf heeft <soort datum> aanvang en periode valt binnen de onzekerheidsperiode datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20220810                      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-16         |
      | datumTot                         | 2022-05-26         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-16 tot 2022-05-26 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | soort datum                                  |
      | 20220500      | gedeeltelijk (jaar en maand) onbekende datum |
      | 20220000      | gedeeltelijk (jaar) onbekende datum          |
      | 00000000      | volledig onbekende datum                     |

    Abstract Scenario: onderzoek met aanduiding in onderzoek waarde '589999' is beëindigd voor datum aanvang volgende verblijf en verblijf heeft <soort datum> aanvang en periode overlapt de onzekerheidsperiode datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20230809                      | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2024-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000001            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000001  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang | periode mogelijke bewoner | periode bewoner           | soort datum                                  |
      | 20220500      | 2022-05-01 tot 2022-06-01 | 2022-06-01 tot 2023-08-10 | gedeeltelijk (jaar en maand) onbekende datum |
      | 20220000      | 2022-01-01 tot 2023-01-01 | 2023-01-01 tot 2023-08-10 | gedeeltelijk (jaar) onbekende datum          |

    Abstract Scenario: onderzoek met aanduiding in onderzoek waarde '589999' is beëindigd voor <soort datum> aanvang volgende verblijf en periode overlapt de hele onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20210526                       | 20211014                      | 20200810                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2024-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000001  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000001            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang volgende | periode bewoner           | periode mogelijke bewoner | soort datum                                  |
      | 20220500               | 2021-01-01 tot 2022-05-01 | 2022-05-01 tot 2023-06-01 | gedeeltelijk (jaar en maand) onbekende datum |
      | 20220000               | 2021-01-01 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 | gedeeltelijk (jaar) onbekende datum          |

    Abstract Scenario: onderzoek met aanduiding in onderzoek waarde '589999' is beëindigd voor <soort datum> aanvang volgende verblijf en volgende verblijf heeft <soort datum> aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20211114                       | <datum einde onderzoek>       | 20200430                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2024-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde            |
      | periode                          | <periode bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000001  |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <periode mogelijke bewoner> |
      | adresseerbaarObjectIdentificatie | 0800010000000001            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum einde onderzoek | datum aanvang volgende | periode bewoner           | periode mogelijke bewoner | soort datum                                  | scenario                                                       |
      | 20220427              | 20220500               | 2022-01-01 tot 2022-05-01 | 2022-05-01 tot 2022-06-01 | gedeeltelijk (jaar en maand) onbekende datum | datum einde onderzoek voor onzekerheidsperiode volgende        |
      | 20220516              | 20220500               | 2022-01-01 tot 2022-05-01 | 2022-05-01 tot 2022-06-01 | gedeeltelijk (jaar en maand) onbekende datum | datum einde onderzoek in onzekerheidsperiode volgende          |
      | 20220531              | 20220500               | 2022-01-01 tot 2022-05-01 | 2022-05-01 tot 2022-06-01 | gedeeltelijk (jaar en maand) onbekende datum | datum einde onderzoek laatste dag onzekerheidsperiode volgende |
      | 20211230              | 20220000               | 2022-01-01 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 | gedeeltelijk (jaar) onbekende datum          | datum einde onderzoek voor onzekerheidsperiode volgende        |
      | 20220516              | 20220000               | 2022-01-01 tot 2022-01-01 | 2022-01-01 tot 2023-01-01 | gedeeltelijk (jaar) onbekende datum          | datum einde onderzoek in onzekerheidsperiode volgende          |
