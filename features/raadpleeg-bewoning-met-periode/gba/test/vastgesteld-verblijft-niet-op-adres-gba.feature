#language: nl

Functionaliteit: bijzondere situaties 'indicatie vastgesteld verblijft niet op adres' bij bewoning met periode

  Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt niet geleverd als bewoner vanaf de ingangsdatum van het onderzoek

    Abstract Scenario: persoon verblijft niet meer op het gevraagde adres en stond daar ingeschreven met <soort datum> aanvang en gevraagde periode overlapt de datum ingang onderzoek binnen de onzekerheidsperiode van datum aanvang
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 589999                          | 20220526                       | <datum aanvang>                    |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20220810                           |
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

    Abstract Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum en <scenario>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 589999                          | 20220526                       | 20200818                           |
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

    Scenario: persoon verblijft niet meer op het gevraagde adres en is inmiddels ingeschreven met gedeeltelijk onbekende vertrekdatum en periode loopt tot in de onzekerheidsperiode van volgende verblijf
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 589999                          | 20220526                       | 20200818                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20220600                               |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-28         |
      | datumTot                         | 2022-06-15         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |


  Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt geleverd als mogelijke bewoner tot de ingangsdatum van het onderzoek

    Abstract Scenario: persoon verblijft mogelijk nog op het gevraagde adres en stond daar ingeschreven met <soort datum> aanvang en <scenario>
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
      | 089999                          | 20220526                       | <datum aanvang>                    |
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


  Rule: een persoon met beëindigd onderzoek met aanduiding in onderzoek waarde '089999' wordt geleverd als bewoner

    Abstract Scenario: persoon heeft beëindigd onderzoek met aanduiding in onderzoek waarde '589999' en stond daar ingeschreven met <soort datum> aanvang en periode overlapt de datum ingang onderzoek die ligt in de onzekerheidsperiode van datum aanvang
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum einde onderzoek (83.30) | datum aanvang adreshouding (10.30) |
      | 089999                          | 20220526                       | 20221130                      | <datum aanvang>                    |
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
