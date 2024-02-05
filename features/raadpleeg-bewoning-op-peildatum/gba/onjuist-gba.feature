#language: nl

@gba
Functionaliteit: raadpleeg bewoning van een gecorrigeerde verblijfplaats

  Als consumer van de Bewoning API
  wil ik dat bewoning alleen op correcte gegevens wordt gebaseerd en onjuiste (gecorrigeerde) gegevens worden genegeerd

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |

  Rule: gecorrigeerde gegevens worden niet gebruikt

    Scenario: datum aanvang van verblijf is gecorrigeerd en peildatum ligt voor de correcte datum maar na de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | 20160601                           | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-28           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen

    Scenario: datum aanvang van verblijf is gecorrigeerd en peildatum ligt na de correcte datum maar voor de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | 20160526                           | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-28           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2016-05-28 tot 2016-05-29 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    Scenario: datum aanvang van volgende verblijf is gecorrigeerd en peildatum ligt na de correcte datum maar voor de onjuiste datum aanvang volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | 20160526                           | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-28           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen

    Scenario: datum aanvang van volgende verblijf is gecorrigeerd en peildatum ligt voor de correcte datum maar na de onjuiste datum aanvang volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | 20160601                           | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-28           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2016-05-28 tot 2016-05-29 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    Scenario: datum aanvang van verblijf is gecorrigeerd naar een deels onbekende datum en peildatum ligt in de onzekerheidsperiode en voor de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | 20160000                           | W                     |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2016-05-01 tot 2016-05-02 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    Abstract Scenario: datum aanvang van volgende verblijf is gecorrigeerd naar een deels onbekende datum en peildatum ligt in de onzekerheidsperiode en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | functie adres (10.10) |
      | 0800                              | 20160000                           | W                     |
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
      | peildatum  | periode                   | scenario                       |
      | 2016-05-01 | 2016-05-01 tot 2016-05-02 | voor de onjuiste datum aanvang |
      | 2016-06-01 | 2016-06-01 tot 2016-06-02 | na de onjuiste datum aanvang   |

    Abstract Scenario: vorige verblijf is gecorrigeerd naar inschrijving met een deels onbekende datum en peildatum ligt in de onzekerheidsperiode en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160218                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20160526                               |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde           |
      | periode                          | <periode>        |
      | adresseerbaarObjectIdentificatie | 0800010000000002 |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | peildatum  | periode                   | scenario                                                                                 |
      | 2016-05-01 | 2016-05-01 tot 2016-05-02 | voor de datum aanvang onjuiste vorige verblijf en na datum aanvang juiste vorig verblijf |
      | 2016-06-01 | 2016-06-01 tot 2016-06-02 | na de datum aanvang onjuiste vorige verblijf                                             |

    Scenario: vorige verblijf is gecorrigeerd naar inschrijving met een deels onbekende datum en peildatum ligt in de onzekerheidsperiode en voor de datum aanvang onjuiste vorige verblijf en voor datum aanvang juiste vorig verblijf
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160218                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) |
      | 0000         | 20160526                               |
      En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-02-01           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen
