#language: nl

Functionaliteit: raadpleeg bewoning op peildatum voor een infrastructureel gewijzigd adresseerbaar object

Rule: bewoning wordt niet geleverd voor een adresseerbaar object wanneer de peildatum valt vóór datum toevoeging van BAG identificaties

  Abstract Scenario: peildatum valt op of na het toevoegen van BAG identificaties aan het gevraagde adresseerbaar object
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0800                 | Spui               |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En aan adres 'A1' is op '2022-05-01' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800010000000001                         | 0800200010877001                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010011067001 |
    En heeft de bewoning bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   |
    | 2023-01-01 | 2023-01-01 tot 2023-01-02 |
    | 2022-05-01 | 2022-05-01 tot 2022-05-02 |

  Scenario: peildatum valt vóór het toevoegen van BAG identificaties aan het gevraagde adresseerbaar object
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0800                 | Spui               |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' gewijzigd naar de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-04-30           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is overgegaan in een samenvoeging als de peildatum op of na datum samenvoeging ligt

  Scenario: het gevraagde adresseerbaar object is overgegaan in een samenvoeging en peildatum ligt na datum samenvoeging 
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000002                         | 0800200010877001                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is ontstaan uit een samenvoeging als de peildatum vóór datum samenvoeging ligt

  Scenario: het gevraagde adresseerbaar object is ontstaan uit een samenvoeging en peildatum ligt vóór de samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000002                         | 0800200010877001                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000002     |
    Dan heeft de response 0 bewoningen

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is gesplitst en de peildatum ligt op of na datum splitsing

  Scenario: het gevraagde adresseerbaar object is gesplitst en de peildatum ligt na datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010000000002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010000000003                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 20220501                           | W                             |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010000000001     |
    Dan heeft de response 0 bewoningen

Rule: bewoning wordt niet geleverd voor een adresseerbaar object dat is ontstaan uit een splitsing en de peildatum ligt vóór datum splitsing

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit splitsing en de peildatum ligt vóór datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010000000001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010000000002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010000000003                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 20220501                           | W                             |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeildatum                 |
    | peildatum                        | 2022-01-01                           |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response 0 bewoningen

    Voorbeelden:
    | adresseerbaar object identificatie |
    | 0800010000000002                   |
    | 0800010000000003                   |
