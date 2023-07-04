#language: nl

Functionaliteit: persoon met 'indicatie vastgesteld verblijft niet op adres'

  Als afnemer
  Wil ik personen waarvan is vastgesteld dat zij niet op het adres verblijven niet worden geleverd als bewoner
  Zodat ik ze niet zelf hoeft uit te sluiten als bewoner

Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt niet geleverd als bewoner

  Scenario: persoon verblijft niet meer op het gevraagde adres
    Gegeven een adres heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000713450                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op het adres met 'identificatiecode verblijfplaats (11.80)' '0800010000713450' met de volgende gegevens
    | aanduiding in onderzoek (83.10) | datum aanvang adreshouding (10.30) |
    | 089999                          | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000713450     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2020-08-18 tot 2020-08-19 |
    | adresseerbaarObjectIdentificatie | 0800010000713450          |
    En heeft de bewoning voor de bewoningPeriode '2020-08-18 tot 2020-08-19' geen bewoners
