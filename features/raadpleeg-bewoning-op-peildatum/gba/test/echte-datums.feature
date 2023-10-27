#language: nl

@gba
Functionaliteit: bewoning op peildatum met echte datums

    Achtergrond:
      Gegeven adres 'vorige' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'gevraagd' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |
      En adres 'volgende' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En adres 'daaropvolgende' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000004                         |
      
  Rule: geleverde bewoning wordt beperkt door datum aanvang gevraagde verblijf tot datum aanvang volgende verblijf

    Abstract Scenario: eerste en enige verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                            | peildatum  | periode tot |
      | peildatum op datum aanvang adreshouding | 2021-05-26 | 2021-05-27  |
      | peildatum na datum aanvang adreshouding | 2023-10-14 | 2023-10-15  |

    Abstract Scenario: eerste en enige verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                     | peildatum  |
      | peildatum op dag voor datum aanvang adreshouding | 2021-05-25 |
      | peildatum ruim voor datum aanvang adreshouding   | 2020-05-26 |

    Abstract Scenario: volgende verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                        | peildatum  | periode tot |
      | peildatum op datum aanvang adreshouding             | 2021-05-26 | 2021-05-27  |
      | peildatum na datum aanvang adreshouding             | 2021-07-01 | 2021-07-02  |
      | peildatum op dag voor aanvang volgende adreshouding | 2021-10-13 | 2021-10-14  |

    Abstract Scenario: volgende verblijfplaats en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                         | peildatum  |
      | peildatum op dag voor datum aanvang adreshouding     | 2021-05-25 |
      | peildatum ruim voor datum aanvang adreshouding       | 2020-05-26 |
      | peildatum op dag datum aanvang volgende adreshouding | 2021-10-14 |
      | peildatum na aanvang volgende adreshouding           | 2022-05-26 |

    Abstract Scenario: volgende verblijfplaats is verblijf buitenland en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | 20211014                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                        | peildatum  | periode tot |
      | peildatum op datum aanvang adreshouding             | 2021-05-26 | 2021-05-27  |
      | peildatum na datum aanvang adreshouding             | 2021-07-01 | 2021-07-02  |
      | peildatum op dag voor aanvang volgende adreshouding | 2021-10-13 | 2021-10-14  |

    Abstract Scenario: volgende verblijfplaats is verblijf buitenland en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | 20211014                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                         | peildatum  |
      | peildatum op dag voor datum aanvang adreshouding     | 2021-05-25 |
      | peildatum ruim voor datum aanvang adreshouding       | 2020-05-26 |
      | peildatum op dag datum aanvang volgende adreshouding | 2021-10-14 |
      | peildatum na aanvang volgende adreshouding           | 2022-05-26 |

    Scenario: vorige, volgende en daaropvolgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2021-07-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-07-01 tot 2021-07-02 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

  Rule: een persoon is geen bewoner meer vanaf de datum opschorting

    Abstract Scenario: persoon is overleden tijdens verblijf op gevraagde adres en gevraagd wordt peildatum voor overlijden
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20211127                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                        | peildatum  | periode tot |
      | peildatum voor overlijden       | 2021-07-01 | 2021-07-02  |
      | peildatum 1 dag voor overlijden | 2021-11-26 | 2021-11-27  |

    Abstract Scenario: persoon is overleden tijdens verblijf op gevraagde adres en gevraagd wordt peildatum na overlijden
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20211127                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                      | peildatum  |
      | peildatum is datum van overlijden | 2021-11-27 |
      | peildatum na overlijden           | 2022-01-01 |

    Abstract Scenario: persoon is overleden na vertrek uit gevraagde adres en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20211127                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | omschrijving                                        | peildatum  | periode tot |
      | peildatum op datum aanvang adreshouding             | 2021-05-26 | 2021-05-27  |
      | peildatum na datum aanvang adreshouding             | 2021-07-01 | 2021-07-02  |
      | peildatum op dag voor aanvang volgende adreshouding | 2021-07-29 | 2021-07-30  |

    Abstract Scenario: persoon is overleden na vertrek uit gevraagde adres en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      En de persoon heeft de volgende 'inschrijving' gegevens
      | datum opschorting bijhouding (67.10) | reden opschorting bijhouding (67.20) |
      | 20211127                             | O                                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                             | peildatum  |
      | peildatum op datum aanvang volgende adreshouding         | 2021-07-30 |
      | peildatum na datum aanvang volgende maar voor overlijden | 2021-09-01 |
      | peildatum is datum overlijden                            | 2021-11-27 |
      | peildatum na datum overlijden                            | 2022-01-01 |

  Rule: onjuist wordt genegeerd

    Abstract Scenario: verblijf is gecorrigeerd, persoon heeft hier nooit gewoond en <omschrijving>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
       En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | omschrijving                                             | peildatum  |
      | peildatum is oorspronkelijke (onjuiste) datum aanvang    | 2021-05-16 |
      | peildatum is gecorrigeerde datum aanvang                 | 2021-05-26 |
      | peildatum tussen onjuiste en gecorrigeerde datum aanvang | 2021-05-18 |
      | peildatum na gecorrigeerde datum aanvang                 | 2021-06-01 |

    Abstract Scenario: <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                                                       | nieuwe datum | peildatum  | periode tot |
      | datum aanvang is gecorrigeerd naar eerdere datum en peildatum is nieuwe datum aanvang          | 20210520     | 2021-05-20 | 2021-05-21  |
      | datum aanvang is gecorrigeerd naar eerdere datum en peildatum na nieuwe datum aanvang          | 20210523     | 2021-05-23 | 2021-05-24  |
      | datum aanvang is gecorrigeerd naar eerdere datum en peildatum na oorspronkelijke datum aanvang | 20210520     | 2021-06-12 | 2021-06-13  |
      | datum aanvang is gecorrigeerd naar latere datum en peildatum is nieuwe datum aanvang           | 20210529     | 2021-05-29 | 2021-05-30  |
      | datum aanvang is gecorrigeerd naar latere datum en peildatum na nieuwe datum aanvang           | 20210529     | 2021-06-12 | 2021-06-13  |

    Abstract Scenario: <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                                                             | nieuwe datum | peildatum  |
      | datum aanvang is gecorrigeerd naar eerdere datum en peildatum is dag voor nieuwe datum aanvang       | 20210520     | 2021-05-19 |
      | datum aanvang is gecorrigeerd naar latere datum en peildatum tussen onjuiste en nieuwe datum aanvang | 20210529     | 2021-05-27 |

    Abstract Scenario: <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                                                                   | nieuwe datum | peildatum  | periode tot |
      | datum aanvang volgende is gecorrigeerd naar eerdere datum en peildatum ligt voor nieuwe datum              | 20210725     | 2021-07-24 | 2021-07-25  |
      | datum aanvang volgende is gecorrigeerd naar latere datum en peildatum ligt tussen onjuiste en nieuwe datum | 20210803     | 2021-08-02 | 2021-08-03  |

    Abstract Scenario: <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                                                                    | nieuwe datum | peildatum  |
      | datum aanvang volgende is gecorrigeerd naar eerdere datum en peildatum is nieuwe datum                      | 20210725     | 2021-07-25 |
      | datum aanvang volgende is gecorrigeerd naar eerdere datum en peildatum ligt tussen onjuiste en nieuwe datum | 20210725     | 2021-07-27 |
      | datum aanvang volgende is gecorrigeerd naar latere datum en peildatum is nieuwe datum                       | 20210803     | 2021-08-03 |

    Abstract Scenario: verblijf op gevraagde adres is onjuist en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2021-05-26           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                 | nieuwe datum |
      | gecorrigeerde verblijf begint op datum onjuiste verblijf | 20210526     | 
      | gecorrigeerde verblijf begint op datum vorige            | 20210516     |
    
    Abstract Scenario: volgende verblijf is onjuist
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | scenario                                                                                           | nieuwe datum | peildatum  | periode tot |
      | gecorrigeerde verblijf begint op datum onjuiste verblijf en peildatum is datum onjuiste verblijf   | 20210730     | 2021-07-30 | 2021-07-31  |
      | gecorrigeerde verblijf begint op datum onjuiste verblijf en peildatum voor datum onjuiste verblijf | 20210730     | 2021-07-01 | 2021-07-02  |
      | gecorrigeerde verblijf begint op datum onjuiste verblijf en peildatum na datum onjuiste verblijf   | 20210730     | 2021-09-01 | 2021-09-02  |
      | gecorrigeerde verblijf begint op datum gevraagde verblijf en peildatum is datum onjuiste verblijf  | 20210526     | 2021-07-30 | 2021-07-31  |
      | gecorrigeerde verblijf begint op datum gevraagde verblijf en peildatum na datum onjuiste verblijf  | 20210526     | 2021-09-01 | 2021-09-02  |

    Abstract Scenario: volgende verblijf is onjuist en peildatum ligt na datum aanvang daaropvolgende verblijf
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'vorige' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210516                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210526                           |
      En de persoon is vervolgens ingeschreven op adres 'volgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20210730                           |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <nieuwe datum>                     |
      En de persoon is vervolgens ingeschreven op adres 'daaropvolgende' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20211014                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2021-10-14           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | scenario                                                  | nieuwe datum |
      | gecorrigeerde verblijf begint op datum onjuiste verblijf  | 20210730     |
      | gecorrigeerde verblijf begint op datum gevraagde verblijf | 20210526     |