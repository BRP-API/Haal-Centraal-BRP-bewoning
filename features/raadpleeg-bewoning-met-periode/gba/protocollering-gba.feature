#language: nl

@gba @protocollering
Functionaliteit: Protocolleer gebruik van BewoningMetPeriode
  Zoeken en raadplegen van gegevens van burgers worden "geprotocolleerd" (formeel gelogd).

  Protocollering moet gebeuren op twee niveau's:
  - bij de RvIG op het niveau van afnemende organisaties
  - bij de afnemende organisatie op het niveau van gebruikers

  Deze feature beschrijft alleen de werking van protocollering op het niveau van afnemende organisaties bij de bron (RvIG)

  Daarin worden de volgende gegevens vastgelegd:
  - request_id: unieke identificatie van de berichtuitwisseling
  - request_datum: tijdstip waarop de protocollering is vastgelegd
  - afnemer_code: identificatiecode van de afnemende organisatie, zoals die is opgenomen in de gestuurde Oauth 2 token
  - anummer: het A-nummer van de persoon waarvan gegevens zijn gevraagd of geleverd
  - request_zoek_rubrieken: lijst van alle parameters die in het request gebruikt zijn, vertaald naar LO-BRP elementnummers
  - request_gevraagde_rubrieken: lijst van alle gegevens die met fields gevraagd zijn, vertaald naar LO-BRP elementnummers
  - verwerkt: vaste waarde false (boolean)

  Zowel request_zoek_rubrieken als request_gevraagde_rubrieken bevatten de LO-BRP elementnummers als 6 cijferig rubrieknummer (incl. voorloopnul), gescheiden door komma spatie, en oplopend gesorteerd.

  Rule: Parameters datumVan en datumTot filteren op datum aanvang adreshouding (08.10.30) en datum aanvang adres buitenland (08.13.20), parameter adresseerbaarObjectIdentificatie zoekt op identificatiecode verblijfplaats (08.11.80)

    Scenario: Raadpleeg bewoning op periode
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_zoek_rubrieken |
      | 081030, 081180, 081320 |

 
  Rule: Bij bewoning wordt alleen het burgerservicenummer (01.01.20) van de persoon gevraagd.

    Scenario: Burgerservicenummer (010120) wordt vastgelegd in 'request_gevraagde_rubrieken'
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken |
      | 010120                      |

  Rule: Wanneer in het antwoord meerdere personen worden geleverd, dan wordt er per geleverde persoon een protocolleringsrecord opgenomen
    
    Scenario: Meerdere bewoners gevonden op periode
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200818                           |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken | request_zoek_rubrieken |
      | 010120                      | 081030, 081180, 081320 |
      En heeft de persoon met burgerservicenummer '000000048' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken | request_zoek_rubrieken |
      | 010120                      | 081030, 081180, 081320 |

  Rule: Wanneer in het antwoord meerdere bewoningen worden geleverd, dan wordt er per geleverde persoon één protocolleringsrecord opgenomen

    Scenario: Meerdere bewoningen gevonden in periode
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20200818                           |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de persoon met burgerservicenummer '000000024' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken | request_zoek_rubrieken |
      | 010120                      | 081030, 081180, 081320 |
      En heeft de persoon met burgerservicenummer '000000048' de volgende 'protocollering' gegevens
      | request_gevraagde_rubrieken | request_zoek_rubrieken |
      | 010120                      | 081030, 081180, 081320 |
      En is voor de geauthenticeerde consumer '2' protocollering regels vastgelegd

