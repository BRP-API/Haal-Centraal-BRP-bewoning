#language: nl

Functionaliteit: persoon met 'indicatie vastgesteld verblijft niet op adres'

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
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | peildatum  | periode                   | scenario                                  |
    | 2022-05-26 | 2022-05-26 tot 2022-05-27 | peildatum valt op de dag ingang onderzoek |
    | 2022-07-12 | 2022-07-12 tot 2022-07-13 | peildatum valt na de dag ingang onderzoek |

Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt geleverd als mogelijke bewoner tot de ingangsdatum van het onderzoek

  Scenario: persoon verblijft mogelijk nog op het gevraagde adres en <scenario>
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum ingang onderzoek (83.20) | datum aanvang adreshouding (10.30) |
    | 089999                          | 20220526                       | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
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
    | 2020-08-18 | 2020-08-18 tot 2020-08-19 | peildatum valt op de datum aanvang van het verblijf           |