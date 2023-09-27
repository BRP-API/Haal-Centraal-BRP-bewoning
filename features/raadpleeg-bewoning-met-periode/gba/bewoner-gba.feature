#language: nl

@gba
Functionaliteit: lever burgerservicenummer van bewoner(s) bij raadpleeg bewoning met periode

    Scenario: de persoon heeft ouders, partners en kinderen die zijn ingeschreven in de BRP
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 000000024 |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 000000036 |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 000000048 |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 000000061 |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                        | waarde    |
      | burgerservicenummer (01.20) | 000000073 |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2022-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: de persoon heeft ouders, partners en kinderen die niet zijn ingeschreven in de BRP
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100818                           |
      En de persoon heeft een ouder '1' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | moeder |
      En de persoon heeft een ouder '2' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | vader  |
      En de persoon heeft een 'partner' met de volgende gegevens
      | naam                  | waarde  |
      | geslachtsnaam (02.40) | partner |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | kind   |
      En de persoon heeft een 'kind' met de volgende gegevens
      | naam                  | waarde |
      | geslachtsnaam (02.40) | kind   |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2021-01-01         |
      | datumTot                         | 2022-01-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2021-01-01 tot 2022-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000001          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
