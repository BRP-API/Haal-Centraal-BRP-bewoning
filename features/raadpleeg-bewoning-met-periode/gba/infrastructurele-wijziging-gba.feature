#language: nl

@gba
Functionaliteit: raadpleeg bewoning in periode voor een infrastructureel gewijzigd adresseerbaar object

Rule: bewoning wordt niet geleverd voor een adresseerbaar object voor (het deel van) de gevraagde periode dat vóór datum toevoeging van BAG identificaties ligt

  Abstract Scenario: gevraagde periode begint op of na datum toevoeging BAG identificaties aan het gevraagde adresseerbaar object
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0800                 | Spui               |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800010000000001                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | <datum van>        |
    | datumTot                         | <datum tot>        |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                      |
    | periode                          | <datum van> tot <datum tot> |
    | adresseerbaarObjectIdentificatie | 0800010000000001            |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | datum van  | datum tot  |
    | 2022-07-01 | 2023-01-01 |
    | 2022-05-01 | 2023-01-01 |

  Scenario: gevraagde periode valt vóór datum toevoeging BAG identificaties aan het gevraagde adresseerbaar object
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0800                 | Spui               |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800010000000001                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2022-04-30         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

  Scenario: gevraagde periode overlapt datum toevoeging BAG identificaties aan het gevraagde adresseerbaar object
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0800                 | Spui               |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800010000000001                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2022-05-01 tot 2023-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is overgegaan in een samenvoeging voor (het deel van) de gevraagde periode dat op en na datum samenvoeging ligt

  Scenario: het gevraagde adresseerbaar object is overgegaan in een samenvoeging en gevraagde periode begint na datum samenvoeging 
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-05-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

  Scenario: het gevraagde adresseerbaar object is overgegaan in een samenvoeging en gevraagde periode overlapt datum samenvoeging 
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2022-01-01 tot 2022-05-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is ontstaan uit een samenvoeging voor (het deel van) de gevraagde periode dat vóór datum samenvoeging ligt

  Scenario: het gevraagde adresseerbaar object is ontstaan uit een samenvoeging en gevraagde periode eindigt vóór datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2022-05-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response 0 bewoningen

  Scenario: het gevraagde adresseerbaar object is ontstaan uit een samenvoeging en gevraagde periode overlapt datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000002   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2022-05-01 tot 2023-01-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000002          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is gesplitst voor (het deel van) de gevraagde periode dat op en na datum splitsing ligt

  Scenario: het gevraagde adresseerbaar object is gesplitst en de gevraagde periode begint na datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010000000002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010000000003                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-05-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response 0 bewoningen

  Scenario: het gevraagde adresseerbaar object is gesplitst en de gevraagde periode overlapt datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010000000002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010000000003                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde             |
    | type                             | BewoningMetPeriode |
    | datumVan                         | 2022-01-01         |
    | datumTot                         | 2023-01-01         |
    | adresseerbaarObjectIdentificatie | 0800010000000001   |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | periode                          | 2022-01-01 tot 2022-05-01 |
    | adresseerbaarObjectIdentificatie | 0800010000000001          |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is ontstaan uit een splitsing voor (het deel van) de gevraagde periode dat vóór datum splitsing ligt

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit splitsing en de gevraagde periode eindigt vóór datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010000000002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010000000003                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeriode                   |
    | datumVan                         | 2022-01-01                           |
    | datumTot                         | 2022-05-01                           |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | adresseerbaar object identificatie |
    | 0800010000000002                   |
    | 0800010000000003                   |

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit splitsing en de gevraagde periode overlapt datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010000000002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010000000003                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 0800                              | 20220501                           | W                             |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeriode                   |
    | datumVan                         | 2022-01-01                           |
    | datumTot                         | 2023-01-01                           |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                               |
    | periode                          | 2022-05-01 tot 2023-01-01            |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer   |
    | <burgerservicenummer> |

    Voorbeelden:
    | adresseerbaar object identificatie | burgerservicenummer |
    | 0800010000000002                   | 000000024           |
    | 0800010000000003                   | 000000048           |
