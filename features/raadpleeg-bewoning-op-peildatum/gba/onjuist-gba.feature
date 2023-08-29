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
      | datum aanvang adreshouding (10.30) |
      | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160601                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-28           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen

    Scenario: datum aanvang van verblijf is gecorrigeerd en peildatum ligt na de correcte datum maar voor de onjuiste datum aanvang
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160526                           |
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
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160601                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-28           |
      | adresseerbaarObjectIdentificatie | 0800010000000001     |
      Dan heeft de response 0 bewoningen

    Scenario: datum aanvang van volgende verblijf is gecorrigeerd en peildatum ligt voor de correcte datum maar na de onjuiste datum aanvang volgende verblijf
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160601                           |
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
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2016-05-1            |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                  |
      | periode                          | 2016-05-1 tot 2016-05-2 |
      | adresseerbaarObjectIdentificatie | 0800010000000002        |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    Abstract Scenario: datum aanvang van volgende verblijf is gecorrigeerd naar een deels onbekende datum en peildatum ligt in de onzekerheidsperiode en <scenario>
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160526                           |
      En de 'verblijfplaats' is gecorrigeerd naar de volgende gegevens
      | datum aanvang adreshouding (10.30) |
      | 20160000                           |
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
      | peildatum | periode                 | scenario                       |
      | 2016-05-1 | 2016-05-1 tot 2016-05-2 | voor de onjuiste datum aanvang |
      | 2016-06-1 | 2016-06-1 tot 2016-06-2 | na de onjuiste datum aanvang   |
