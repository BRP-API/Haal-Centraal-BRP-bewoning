# language: nl

@gba @autorisatie
Functionaliteit: Elke wijziging van de samenstelling van bewoners van een adresseerbaar object leidt tot een bewoning

  Achtergrond:
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000001                         |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000002                         |
    En adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20170210                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20211208                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220601                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220201                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220401                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20181026                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220401                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220801                           |
    En de persoon met burgerservicenummer '000000061' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20181026                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20221001                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20221201                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20230201                           |
    En de persoon met burgerservicenummer '000000073' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20190403                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20221001                           |

  Rule: Elke wijziging van de samenstelling van bewoners van een adresseerbaar object leidt tot een bewoning

    Scenario: een nieuwe bewoner (000000024) verhuist naar het adres in de gevraagde periode, wordt dit een extra bewoning
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2022-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-02-01 tot 2022-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

    Scenario: een bewoner (000000012) vertrekt in de gevraagde periode, wordt dit een nieuwe bewoning
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-01         |
      | datumTot                         | 2022-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-01 tot 2022-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000048           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-06-01 tot 2022-07-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |

    Scenario: een bewoner (000000061) vertrekt en komt daarna weer op hetzelfde adres te wonen
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-11-01         |
      | datumTot                         | 2023-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-11-01 tot 2022-12-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000061           |
      | 000000073           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-12-01 tot 2023-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000073           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2023-02-01 tot 2023-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000061           |
      | 000000073           |

    Scenario: een bewoner (000000024) vertrekt op dezelfde dag dat een andere bewoner (000000048) op het adres komt wonen
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-03-01         |
      | datumTot                         | 2022-05-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-03-01 tot 2022-04-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-04-01 tot 2022-05-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000048           |
  

  Rule: er wordt geen bewoning geleverd zonder bewoners of mogelijke bewoners

    Scenario: tijdelijk is er geen enkele bewoner in de periode, dus is er geen bewoning voor de periode zonder bewoners
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-07-01         |
      | datumTot                         | 2022-11-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-07-01 tot 2022-08-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-10-01 tot 2022-11-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000061           |
      | 000000073           |


  Rule: datumTot van een periode bevat de bewoning tot en met 1 dag vóór datumTot en is minimaal 1 dag later dan datumVan

    Scenario: datumTot van de gevraagde periode is gelijk aan de datum dat een bewoner (000000024) er is komen wonen
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2022-02-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: datumTot van de gevraagde periode is 1 dag later dan de datum dat een bewoner (000000024) er is komen wonen
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-01-01         |
      | datumTot                         | 2022-02-02         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-01-01 tot 2022-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-02-01 tot 2022-02-02 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

    Scenario: datumTot van de gevraagde periode is gelijk aan de datum (2022-06-01) dat een bewoner (000000012) is vertrokken naar een ander adres
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-01         |
      | datumTot                         | 2022-06-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-01 tot 2022-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000048           |

    Scenario: datumTot van de gevraagde periode is 1 dag nadat een bewoner (000000012) is vertrokken naar een ander adres
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-01         |
      | datumTot                         | 2022-06-02         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-01 tot 2022-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000048           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-06-01 tot 2022-06-02 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |

    Scenario: datumVan van de gevraagde periode is gelijk aan de datum dat een bewoner (000000012) is vertrokken naar een ander adres
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-06-01         |
      | datumTot                         | 2022-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-06-01 tot 2022-07-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |
    
    Scenario: datumVan van de gevraagde periode is 1 dag voor de datum dat een bewoner (000000012) is vertrokken naar een ander adres
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2022-05-31         |
      | datumTot                         | 2022-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-05-31 tot 2022-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000048           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-06-01 tot 2022-07-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000048           |


  Rule: meerdere aaneensluitende verblijfplaatsen op hetzelfde adresseerbaar object als gevolg wijzigen of samenvoegen van gemeenten, met dezelfde (mede)bewoners, wordt als één bewoning gezien

    Scenario: Adres ligt in samengevoegde gemeente en periode overlapt het moment van samenvoegen
      Gegeven gemeente 'G1' heeft de volgende gegevens
      | gemeentecode (92.10) | gemeentenaam (92.11) |
      | 9999                 | Ons Dorp             |
      En adres 'A6' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 9999                 | 9999010000000006                         |
      En de persoon met burgerservicenummer '000000085' is ingeschreven op adres 'A6' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 9999                              | 20100818                           |
      En gemeente 'G1' is samengevoegd met de volgende gegevens
      | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
      | 0800                        | 20230526                  |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2023-05-01         |
      | datumTot                         | 2023-06-01         |
      | adresseerbaarObjectIdentificatie | 9999010000000006   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2023-05-01 tot 2023-06-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000006          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000085           |
