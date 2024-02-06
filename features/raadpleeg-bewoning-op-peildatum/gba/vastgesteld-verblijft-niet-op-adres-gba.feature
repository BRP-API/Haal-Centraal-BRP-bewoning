#language: nl

@gba
Functionaliteit: persoon met 'indicatie vastgesteld verblijft niet op adres' bij bewoning met peildatum

  Als afnemer
  Wil ik personen waarvan is vastgesteld dat zij niet meer op het adres verblijven niet worden geleverd als bewoner
  Zodat ik ze niet zelf hoeft uit te sluiten als bewoner


    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |


  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999' wordt niet geleverd als bewoner vanaf de ingangsdatum van het onderzoek

    Abstract Scenario: persoon verblijft niet meer op het gevraagde adres en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 089999                          | 20220526                       | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | peildatum  | periode                   | scenario                                  |
      | 2022-05-26 | 2022-05-26 tot 2022-05-27 | peildatum valt op de dag ingang onderzoek |
      | 2022-07-12 | 2022-07-12 tot 2022-07-13 | peildatum valt na de dag ingang onderzoek |

    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven op een ander adres en peildatum ligt na aanvang onderzoek en voor aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-06-03           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen

    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum en peildatum ligt in de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220600                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-06-03           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen


  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999' wordt geleverd als mogelijke bewoner tot de ingangsdatum van het onderzoek

    Scenario: persoon verblijft mogelijk nog op het gevraagde adres en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 089999                          | 20220526                       | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                |
      | 2022-05-25 | 2022-05-25 tot 2022-05-26 | peildatum valt op de dag voor de datum ingang onderzoek |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum valt voor de datum ingang onderzoek           |
      | 2020-08-18 | 2020-08-18 tot 2020-08-19 | peildatum valt op de datum aanvang van het verblijf     |

    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven op een ander adres en peildatum ligt voor aanvang onderzoek en voor aanvang volgende
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20200818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-04-10           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-04-10 tot 2022-04-11 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |


  Rule: een persoon met beëindigd onderzoek met aanduiding in onderzoek waarde '089999' op de actuele verblijfplaats wordt geleverd als bewoner

    Abstract Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '089999' in de actuele verblijfplaats en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 089999                          | 20220526                       | 20220810                      | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                                              |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum valt voor de datum ingang onderzoek en na datum aanvang verblijf                                            |
      | 2022-07-12 | 2022-07-12 tot 2022-07-13 | peildatum valt na de dag ingang onderzoek en voor datum einde onderzoek en voor datum aanvang volgende verblijfplaats |
      | 2022-08-12 | 2022-08-12 tot 2022-08-13 | peildatum valt na de dag ingang onderzoek en na datum einde onderzoek                                                 |


  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999' op een historische verblijfplaats en het onderzoek is beëindigd op of voor datum aanvang van de volgende verblijfplaats wordt geleverd als bewoner

    Abstract Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '589999' en is <omschrijving aanvang> ingeschreven op een ander adres en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20220810                      | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | <datum aanvang volgende>               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang volgende | peildatum  | periode                   | omschrijving omvang                      | scenario                                                                                                              |
      | 20220801               | 2022-01-01 | 2022-01-01 tot 2022-01-02 | na beëindigen van het onderzoek          | peildatum valt voor de datum ingang onderzoek en na datum aanvang verblijf                                            |
      | 20220810               | 2022-01-01 | 2022-01-01 tot 2022-01-02 | vanaf datum beëindigen van het onderzoek | peildatum valt voor de datum ingang onderzoek en na datum aanvang verblijf                                            |
      | 20220801               | 2022-07-12 | 2022-07-12 tot 2022-07-13 | na beëindigen van het onderzoek          | peildatum valt na de dag ingang onderzoek en voor datum einde onderzoek en voor datum aanvang volgende verblijfplaats |
      | 20220810               | 2022-07-12 | 2022-07-12 tot 2022-07-13 | vanaf datum beëindigen van het onderzoek | peildatum valt na de dag ingang onderzoek en voor datum einde onderzoek en voor datum aanvang volgende verblijfplaats |
      | 20220801               | 2022-08-12 | 2022-08-12 tot 2022-08-13 | na beëindigen van het onderzoek          | peildatum valt na de dag ingang onderzoek en na datum einde onderzoek en voor datum aanvang volgende verblijfplaats   |
      | 20220810               | 2022-08-12 | 2022-08-12 tot 2022-08-13 | vanaf datum beëindigen van het onderzoek | peildatum valt na de dag ingang onderzoek en na datum einde onderzoek en voor datum aanvang volgende verblijfplaats   |


  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999' op een historische verblijfplaats en het onderzoek is beëindigd binnen de onzekerheidsperiode van datum aanvang van de volgende verblijfplaats wordt geleverd als bewoner in de periode voor de onzekerheidsperiode en als mogelijke bewoner in de onzekerheidsperiode van de volgende verblijfplaats

    Abstract Scenario: onderzoek met aanduiding in onderzoek waarde '589999' is beëindigd in de onzekerheidsperiode <soort datum> aanvang volgende verblijf en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20211014                       | 20220516                      | 20200810                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang volgende>           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een <soort bewoner> met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang volgende | peildatum  | periode                   | soort bewoner     | soort datum                                  | scenario                                                   |
      | 20220500               | 2022-04-30 | 2022-04-30 tot 2022-05-01 | bewoner           | gedeeltelijk (jaar en maand) onbekende datum | peildatum ligt voor onzekerheidsperiode volgende verblijf  |
      | 20220500               | 2022-05-16 | 2022-05-16 tot 2022-05-17 | mogelijke bewoner | gedeeltelijk (jaar en maand) onbekende datum | peildatum ligt in de onzekerheidsperiode volgende verblijf |
      | 20220000               | 2021-01-01 | 2021-01-01 tot 2021-01-02 | bewoner           | gedeeltelijk (jaar) onbekende datum          | peildatum ligt voor onzekerheidsperiode volgende verblijf  |
      | 20220000               | 2022-01-01 | 2022-01-01 tot 2022-01-02 | mogelijke bewoner | gedeeltelijk (jaar) onbekende datum          | peildatum ligt in de onzekerheidsperiode volgende verblijf |
      | 00000000               | 2021-01-01 | 2021-01-01 tot 2021-01-02 | mogelijke bewoner | volledig onbekende datum                     | peildatum ligt in de onzekerheidsperiode volgende verblijf |

  Rule: een persoon met aanduiding in onderzoek waarde '089999' of '589999' op een historische verblijfplaats en het onderzoek is beëindigd na datum aanvang van de volgende verblijfplaats wordt geleverd als mogelijke bewoner
    # wanneer het onderzoek is beëindigd na datum aanvang van de volgende verblijfplaats is niet met zekerheid te bepalen waarom het onderzoek beëindigd is
    # het onderzoek kan bijvoorbeeld beëindigd zijn door een andere gemeente dan waar het onderzoek betrekking op had, zonder dat die gemeente heeft bepaald dat 'vastgesteld geen bewoner meer' niet meer van toepassing is

    Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '<aanduiding onderzoek>' en is inmiddels ingeschreven op een ander adres en onderzoek is beëindigd na aanvang van de volgende verblijfplaats en <scenario>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 0800                              | 589999                          | 20220526                       | 20220902                      | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220901                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                      |
      | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum voor datum ingang van het onderzoek |
      | 2022-07-30 | 2022-07-30 tot 2022-07-31 | peildatum tijdens het onderzoek               |
    
    
