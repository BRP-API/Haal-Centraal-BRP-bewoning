# language: nl

@gba @autorisatie
Functionaliteit: autorisatie voor het gebruik van de API BewoningMetPeriode
  Autorisatie voor het gebruik van de API gebeurt op twee niveau's:
  1. autorisatie van de gebruiker door de afnemende organisatie
  2. autorisatie van de afnemer (organisatie) door RvIG

  Deze feature beschrijft alleen de autorisatie van de afnemer door RvIG.

  Voorlopig wordt de Bewoning API alleen aangeboden aan gemeenten voor het raadplegen van adresseerbare object binnen de eigen gemeente.

  Autorisatie wordt verkregen met behulp van een OAuth 2 token. 
  In het verkregen token is de afnemerindicatie opgenomen die de afnemer uniek identificeert. Op basis van de afnemerindicatie kan de autorisatie worden opgezocht.
  Wanneer de afnemer een gemeente is, is er ook een gemeentecode opgenomen in de OAuth token. Deze wordt gebruikt om te bepalen of het bevraagde adres binnen de eigen gemeente ligt.

  Voor één afnemer kunnen er meerdere rijen zijn in de autorisatietabel, maar daarvan kan er maar één actueel zijn. Alleen de actuele mag worden gebruikt.
  Een autorisatie is actueel wanneer de Datum ingang (35.99.98) in het verleden ligt en Datum beëindiging tabelregel (35.99.99) leeg is of in de toekomst ligt.

  Autorisatie voor bewoning wordt bepaald door de gemeente waar het gevraagde adresseerbaar object ligt in de gevraagde periode.
  Een afnemer is niet geautoriseerd voor een vraag naar bewoning, wanneer het juiste antwoord op die vraag ten minste één bewoning zou geven buiten de eigen gemeente.

  # To Do (t.z.t.): regels voor autorisatie op basis van een autorisatiebesluit
  # To Do (t.z.t.): regels voor leveren persoonsgegevens met geheimhouding aan derde (35.95.12)
  # To Do (t.z.t.): regels voor voorwaarderegel ad hoc (35.95.61)


    Achtergrond:
      Gegeven de afnemer met indicatie '000008' heeft de volgende 'autorisatie' gegevens
      | Rubrieknummer ad hoc (35.95.60) | Medium ad hoc (35.95.67) | Datum ingang (35.99.98) |
      | 10120                           | N                        | 20201128                |
      En de geauthenticeerde consumer heeft de volgende 'claim' gegevens
      | afnemerID | gemeenteCode |
      | 000008    | 0800         |
      En adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0518                 | 0518010000000002                         |


  Rule: Een gemeente als afnemer is geautoriseerd voor het bevragen van bewoning van een adresseerbaar object binnen de eigen gemeente.

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object buiten de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20041103                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

  Rule: Een gemeente als afnemer is geautoriseerd voor het bevragen van bewoning van een adresseerbaar object binnen de eigen gemeente, ongeacht of de bewoner(s) nu nog zijn ingeschreven in de eigen gemeente.
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente en de bewoner is nu niet meer ingeschreven in de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230526                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object buiten de gemeente en de bewoner is nu wel ingeschreven in de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20041103                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230601                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

  Rule: Een gemeente als afnemer is geautoriseerd voor het bevragen van bewoning van een adresseerbaar object binnen de eigen gemeente, ook wanneer de bewoners binnen de gevraagde periode ook buiten de gemeente hebben gewoond

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente en de bewoner is binnen de periode verhuisd buiten de gemeente
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20220820                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

    Scenario: Gemeente raadpleegt bewoning van een adresseerbaar object binnen de gemeente en de bewoner is binnen de periode vertrokken naar het buitenland
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
      | land (13.10) | datum aanvang adres buitenland (13.20) | regel 1 adres buitenland (13.30) | regel 2 adres buitenland (13.40) | regel 3 adres buitenland (13.50) |
      | 5010         | 20220820                               | Rue du pomme 26                  | Bruxelles                        | postcode 1000                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response 1 bewoning

  Rule: Een gemeente als afnemer is geautoriseerd voor het bevragen van bewoning van een adresseerbaar object dat is overgegaan van een andere gemeente vanaf het moment van overgaan

    Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen en periode ligt na de herindeling
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-07-01         |
      | datumTot                         | 2023-08-01         |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen en periode ligt voor de herindeling
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

    @fout-case
    Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen en de herindeling vindt plaats binnen de gevraagde periode
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-01-01         |
      | datumTot                         | 2023-07-01         |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

  Rule: Een gemeente als afnemer is geautoriseerd voor het bevragen van bewoning van een adresseerbaar object dat is overgegaan naar een andere gemeente tot het moment van overgaan

    Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en periode ligt voor datum herindeling
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0530                 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response 1 bewoning

    @fout-case
    Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en periode ligt na datum herindeling
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0530                 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-07-01         |
      | datumTot                         | 2023-08-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

    @fout-case
    Scenario: Adres is na gemeentelijke herindeling in andere gemeente komen te liggen en datum herindeling valt binnen de periode
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0530                 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-05-01         |
      | datumTot                         | 2023-06-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000003   |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                                                 |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.3                            |
      | title    | U bent niet geautoriseerd voor deze vraag.                                             |
      | status   | 403                                                                                    |
      | detail   | Je mag alleen bewoning van adresseerbare objecten binnen de eigen gemeente raadplegen. |
      | code     | unauthorized                                                                           |
      | instance | /haalcentraal/api/bewoning/bewoningen                                                  |

  Rule: Een gemeente als afnemer is geautoriseerd voor de hele onzekerheidsperiode van de datum aanvang een verblijf in de eigen gemeente

    Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen en een bewoner heeft gedeeltelijk onbekende datum aanvang adreshouding en periode valt na de datum herindeling en binnen de onzekerheidsperiode van de datum aanvang
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20100818                           |
      En adres 'A3' is op '2023-05-26' infrastructureel gewijzigd met de volgende gegevens
      | gemeentecode (92.10) |
      | 0800                 |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20230000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-07-01         |
      | datumTot                         | 2023-08-01         |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response 1 bewoning

  Rule: Alleen de bewoning in de gevraagde periode is bepalend voor autorisatie. Het is voor autorisatie niet relevant of het adresseerbaar object voor of na de periode in een andere gemeente lag.

    Scenario: Het adresseerbaar object wordt niet gevonden en dus is er kan de gemeente van het adresseerbaarbaar object niet gelijk of ongelijk zijn aan de afnemer
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2010-01-01         |
      | datumTot                         | 2010-08-17         |
      | adresseerbaarObjectIdentificatie | 1234010000123456   |
      Dan heeft de response 0 bewoningen

    Scenario: Het adresseerbaar object wordt niet bewoond in de gevraagde periode en dus is er kan de gemeente van het adresseerbaarbaar object in die periode niet gelijk of ongelijk zijn aan de afnemer
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20230701                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2023-01-01         |
      | adresseerbaarObjectIdentificatie | 0518010000000002   |
      Dan heeft de response 0 bewoningen

    Abstract Scenario: Adres is na gemeentelijke herindeling in vragende gemeente komen te liggen, tijdens verblijf van een vorige bewoner lag het nog in de andere gemeente en tijdens de bewoning in de gevraagde periode ligt het adres in de vragende gemeente
      Gegeven adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0530                 | 0530010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0530                              | 20100818                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0518                              | 20150526                           |
      En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang>                    |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-06-15         |
      | datumTot                         | 2023-07-15         |
      | adresseerbaarObjectIdentificatie | 0530010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | datum aanvang | scenario                                                                                                      |
      | 20230601      | datum aanvang ligt voor de periode                                                                            |
      | 20230615      | datum aanvang is eerste dag van de periode                                                                    |
      | 20230701      | datum aanvang ligt in de periode                                                                              |
      | 20230400      | datum aanvang is gedeeltelijk onbekend en ligt voor de periode                                                |
      | 20230700      | datum aanvang is gedeeltelijk onbekend en onzekerheidsperiode overlapt gedeeltelijk met gevraagde periode     |
      | 20230000      | datum aanvang is gedeeltelijk onbekend en gevraagde periode valt in zijn geheel binnen de onzekerheidsperiode |

  Rule: Een gemeente als afnemer is geautoriseerd voor het bevragen van bewoning van een adresseerbaar object in een gemeente die is overgegaan of samengevoegd met de afnemer gemeente
    Dit is te herkennen aan nieuwe gemeentecode (92.12) in de gemeententabel.

    Abstract Scenario: Adres ligt in samengevoegde gemeente en <scenario>
      Gegeven gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 9999                 | Ons Dorp             |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 9999                 | 9999010000000003                         |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 9999                              | 20100818                           |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 0800                        | 20230526                  |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | <datum van>        |
      | datumTot                         | <datum tot>        |
      | adresseerbaarObjectIdentificatie | 9999010000000003   |
      Dan heeft de response 1 bewoning

      Voorbeelden:
      | datum van  | datum tot  | scenario                                                                                                                                 |
      | 2023-07-01 | 2023-08-01 | periode ligt na datum samenvoeging (adresseerbaar object ligt in gemeente 0800)                                                          |
      | 2022-01-01 | 2023-01-01 | periode ligt voor datum samenvoeging (adresseerbaar object ligt in gemeente 9999)                                                        |
      | 2023-01-01 | 2023-08-01 | periode overlapt de datum samenvoeging (adresseerbaar object ligt een deel van de periode in gemeente 0800 en een deel in gemeente 9999) |
