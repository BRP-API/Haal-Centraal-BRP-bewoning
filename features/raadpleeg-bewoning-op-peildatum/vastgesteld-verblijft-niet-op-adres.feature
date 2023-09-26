#language: nl

Functionaliteit: persoon met 'indicatie vastgesteld verblijft niet op adres'

  Als afnemer
  Wil ik personen waarvan is vastgesteld dat zij niet op het adres verblijven niet worden geleverd als bewoner
  Zodat ik ze niet zelf hoeft uit te sluiten als bewoner

Rule: een persoon met aanduiding in onderzoek waarde '089999' wordt niet geleverd als bewoner

  Scenario: persoon verblijft niet meer op het gevraagde adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | aanduiding in onderzoek (83.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 089999                          | 20200818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2020-08-18           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen
