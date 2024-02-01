#language: nl

@gba
Functionaliteit: persoon met 'indicatie vastgesteld verblijft niet op adres' bij bewoning met periode

  Als afnemer
  Wil ik personen waarvan is vastgesteld dat zij niet meer op het adres verblijven niet worden geleverd als bewoner
  Zodat ik ze niet zelf hoeft uit te sluiten als bewoner

  Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt niet geleverd als bewoner vanaf de ingangsdatum van het onderzoek

    Abstract Scenario: persoon verblijft niet meer op het gevraagde adres en <scenario>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 089999                          | 20220526                       | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | datum van  | datum tot  | scenario                                  |
      | 2022-05-26 | 2023-05-26 | periode begint op de dag ingang onderzoek |
      | 2022-07-12 | 2022-08-12 | periode begint na de dag ingang onderzoek |

    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven op een ander adres en periode ligt na aanvang onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 589999                          | 20220526                       | 20200818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-06-03         |
      | datumTot                         | 2022-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 0 bewoningen


  Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt geleverd als mogelijke bewoner tot de ingangsdatum van het onderzoek

    Scenario: persoon verblijft mogelijk nog op het gevraagde adres en <scenario>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 089999                          | 20220526                       | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum van  | datum tot  | periode                   | scenario                                            |
      | 2021-01-01 | 2022-01-01 | 2021-01-01 tot 2022-01-01 | periode ligt voor de datum aanvang van het verblijf |
      | 2022-04-26 | 2022-05-26 | 2022-04-26 tot 2022-05-26 | periode loopt tot de datum ingang onderzoek         |
      | 2022-01-01 | 2023-01-01 | 2022-01-01 tot 2022-05-26 | periode loopt tot na de datum ingang onderzoek      |

    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven op een ander adres en <scenario>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 589999                          | 20220526                       | 20200818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum van  | datum tot  | periode                   | scenario                                            |
      | 2021-01-01 | 2022-01-01 | 2021-01-01 tot 2022-01-01 | periode ligt voor de datum aanvang van het verblijf |
      | 2022-04-26 | 2022-05-26 | 2022-04-26 tot 2022-05-26 | periode loopt tot de datum ingang onderzoek         |
      | 2022-01-01 | 2023-01-01 | 2022-01-01 tot 2022-05-26 | periode loopt tot na de datum ingang onderzoek      |


  Rule: een persoon met beëindigd onderzoek met aanduiding in onderzoek waarde '089999' wordt geleverd als bewoner

    Abstract Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '089999' en periode overlapt de duur van het onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 089999                          | 20220526                       | 20220810                      | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001 |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum van  | datum tot  | periode                   | scenario                                        |
      | 2022-01-01 | 2023-01-01 | 2022-01-01 tot 2023-01-01 | periode overlapt de hele duur van het onderzoek |
      | 2022-01-01 | 2022-05-01 | 2022-01-01 tot 2022-05-01 | periode loopt tot voor ingang onderzoek         |
      | 2022-01-01 | 2022-07-01 | 2022-01-01 tot 2022-07-01 | periode loopt tot voor einde onderzoek          |
      
    Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '589999' en is inmiddels ingeschreven op een ander adres en periode overlapt de duur van het onderzoek
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 589999                          | 20220526                       | 20220810                      | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220901                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
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
      | 2022-08-12 | 2022-08-12 tot 2022-08-13 | peildatum valt na de dag ingang onderzoek en na datum einde onderzoek en voor datum aanvang volgende verblijfplaats   |

