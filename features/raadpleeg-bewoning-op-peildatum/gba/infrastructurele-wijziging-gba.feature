#language: nl

@gba
Functionaliteit: raadpleeg bewoning met infrastructurele of technische wijziging

Rule: Wanneer een nieuwe verblijfplaats wordt geregistreerd naar aanleiding van wijzigingen van het adres, dan bevat het vorige verblijfplaats voorkomen de werkelijke datum van inschrijving 
  Wijzigingen aan een adres wordt geregistreerd als een nieuw adres.
  Personen met een verblijfplaats die aan het oude adres refereren, krijgen een nieuw verblijfplaats voorkomen om aan het nieuwe adres te refereren.
  Bij de nieuwe verblijfplaats wordt ook geregistreerd:
  - aangifte adreshouding (72.10) met waarde T (technische wijziging) of W (infrastructurele wijziging)
  - datum aanvang adreshouding (10.30) met de datum dat de nieuwe verblijfplaats is geregistreerd

  Abstract Scenario: bewoning wordt gevraagd van een hernummerd verblijfsobject en <omschrijving>
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' gewijzigd naar de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200022197002                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010011067001 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | omschrijving                                                                  |
    | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum ligt na datum hernummering                                          |
    | 2022-05-01 | 2022-05-01 tot 2022-05-02 | peildatum ligt op datum hernummering                                          |
    | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum ligt vóór datum hernummering en op of na datum aanvang adreshouding |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat na herindeling in een andere gemeente is komen te liggen en <omschrijving>
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0123                 | 0123010011067001                         | 0123200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0123                              | 20100818                           |
    En adres 'A1' is op '2022-05-01' gewijzigd naar de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0123010011067001                         | 0123200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0123010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0123010011067001 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | omschrijving                                                                                |
    | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum ligt na datum gemeentelijke herindeling                                           |
    | 2022-05-01 | 2022-05-01 tot 2022-05-02 | peildatum is datum gemeentelijke herindeling                                                |
    | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum ligt vóór datum gemeentelijke herindeling en op of na datum aanvang adresshouding |

Rule: Wanneer een verblijfsobject in een periode geen adresseerbaar object identificatie heeft, dan wordt er voor die periode geen bewoning geleverd (bewoning onbekend)

  Abstract Scenario: bewoning wordt gevraagd van een verblijfsobject waaraan BAG identificaties zijn toegevoegd en <omschrijving>
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | straatnaam (11.10) |
    | 0800                 | Spui               |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' gewijzigd naar de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | <peildatum>          |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | type                             | Bewoning         |
    | periode                          | <periode>        |
    | adresseerbaarObjectIdentificatie | 0800010011067001 |
    En heeft de bewoning voor de bewoningPeriode '<periode>' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

    Voorbeelden:
    | peildatum  | periode                   | omschrijving                                             |
    | 2023-01-01 | 2023-01-01 tot 2023-01-02 | peildatum ligt na datum toevoegen van BAG identificaties |
    | 2022-05-01 | 2022-05-01 tot 2022-05-02 | peildatum is datum toevoegen van BAG identificaties      |

Rule: bevragen van bewoning van een verblijfsobject dat is ontstaan uit een samengevoeging op een datum vóór de samenvoeging levert (als dit kan worden bepaald) de identificatie van de samengevoegde verblijfsobjecten

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit een samenvoeging en peildatum ligt vóór de samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010022197002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2022-01-01 tot 2022-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit een samenvoeging en peildatum ligt na de samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010022197002     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2023-01-01 tot 2023-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010022197002          |
    En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit samenvoeging en de bewoners zijn gaan samenwonen en de peildatum ligt vóór datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de adressen 'A1, A2' zijn op '2022-05-01' samengevoegd tot adres 'A3' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022192003                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010022192003     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2022-01-01 tot 2022-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |
    | 0800010022197002                 |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit samenvoeging en de bewoners zijn gaan samenwonen en de peildatum ligt na datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de adressen 'A1, A2' zijn op '2022-05-01' samengevoegd tot adres 'A3' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022192003                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010022192003     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2023-01-01 tot 2023-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010022192003          |
    En heeft de bewoning voor de bewoningPeriode '2023-01-01 tot 2023-01-02' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |
    | 000000048           |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit een samenvoeging en de bewoners van een samengevoegd verblijfsobject verhuizen niet naar het nieuw verblijfsobject en de peildatum ligt vóór datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    En adres 'A4' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800000000000004                         | 0800200022192682                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220430                           |
    En de adressen 'A1, A2' zijn op '2022-05-01' samengevoegd tot adres 'A3' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022192003                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010022192003     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2022-01-01 tot 2022-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |

Rule: bevragen van bewoning van een verblijfsobject dat is overgegaan in een samengevoeging op een datum na de samengevoeging levert (als dit kan worden bepaald) de identificatie van het verblijfsobject dat is ontstaan uit samenvoeging

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is overgegaan in een samenvoeging en peildatum ligt vóór datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2022-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                    |
    | type                             | Bewoning                  |
    | periode                          | 2022-01-01 tot 2022-01-02 |
    | adresseerbaarObjectIdentificatie | 0800010011067001          |
    En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
    | burgerservicenummer |
    | 000000024           |

  Abstract Scenario: bewoning wordt gevraagd van een verblijfsobject dat is overgegaan in een samenvoeging en de peildatum ligt vóór datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A2' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de adressen 'A1, A2' zijn op '2022-05-01' samengevoegd tot adres 'A3' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022192003                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeildatum                 |
    | peildatum                        | 2022-01-01                           |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde                               |
    | type                             | Bewoning                             |
    | periode                          | 2022-01-01 tot 2022-01-02            |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    En heeft de bewoning voor de bewoningPeriode '2022-01-01 tot 2022-01-02' bewoners met de volgende gegevens
    | burgerservicenummer   |
    | <burgerservicenummer> |

    Voorbeelden:
    | adresseerbaar object identificatie | burgerservicenummer |
    | 0800010011067001                   | 000000024           |
    | 0800010022197002                   | 000000048           |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is overgegaan in een samenvoeging en peildatum ligt na de samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2023-01-01 tot 2023-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010022197002                 |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is overgegaan in een samenvoeging en de bewoners zijn niet ingeschreven in het samengevoegd verblijfsobject en peildatum ligt na datum samenvoeging
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    Gegeven adres 'A3' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800000000000003                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220430                           |
    En adres 'A1' is op '2022-05-01' samengevoegd tot adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010022197002                         | 0800200010877001                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2023-01-01 tot 2023-01-02   |
    En heeft de bewoning geen oudOfNieuwVerblijfsobjecten

Rule: bevragen van bewoning van een verblijfsobject dat is ontstaan uit een splitsing op een datum vóór de splitsing levert (als dit kan worden bepaald) de identificatie van het gesplitste verblijfsobject

  Abstract Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit splitsing en de peildatum ligt vóór datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010022192003                         | 0800200010877001                           |
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
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeildatum                 |
    | peildatum                        | 2022-01-01                           |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2022-01-01 tot 2022-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |

    Voorbeelden:
    | adresseerbaar object identificatie |
    | 0800010022197002                   |
    | 0800010022192003                   |

  Abstract Scenario: bewoning wordt gevraagd van een verblijfsobject dat is ontstaan uit splitsing en er zijn geen oorspronkelijke bewoners ingeschreven op het verblijfsobject en de peildatum ligt vóór datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010022192003                         | 0800200010877001                           |
    En adres 'A4' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800000000000004                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220501                           |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220501                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                               |
    | type                             | BewoningMetPeildatum                 |
    | peildatum                        | 2022-01-01                           |
    | adresseerbaarObjectIdentificatie | <adresseerbaar object identificatie> |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2022-01-01 tot 2022-01-02   |
    En heeft de bewoning geen oudOfNieuwVerblijfsobjecten

    Voorbeelden:
    | adresseerbaar object identificatie |
    | 0800010022197002                   |
    | 0800010022192003                   |

Rule: bevragen van bewoning van een verblijfsobject dat is gesplitst op een datum na de splitsing levert (als dit kan worden bepaald) de identificatie van de verblijfsobjecten die uit de splitsing zijn ontstaan

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is gesplitst en de peildatum ligt na datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010022192003                         | 0800200010877001                           |
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
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2023-01-01 tot 2023-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010022197002                 |
    | 0800010022192003                 |

  Scenario: bewoning wordt gevraagd van een verblijfsobject dat is gesplitst en één van de uit splitsing ontstaan verblijfsobject bevat geen bewoners van het gesplitste verblijfsobject en de peildatum ligt na datum splitsing
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | 0800                 | 0800010011067001                         | 0800200010877001                           |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) | identificatiecode nummeraanduiding (11.90) |
    | A2    | 0800                 | 0800010022197002                         | 0800200022192682                           |
    | A3    | 0800                 | 0800010022192003                         | 0800200010877001                           |
    En adres 'A4' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800000000000004                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) | aangifte adreshouding (72.10) |
    | 20220501                           | W                             |
    En de persoon met burgerservicenummer '000000048' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20100818                           |
    En de persoon is vervolgens ingeschreven op adres 'A4' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220501                           |
    Als gba bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde               |
    | type                             | BewoningMetPeildatum |
    | peildatum                        | 2023-01-01           |
    | adresseerbaarObjectIdentificatie | 0800010011067001     |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam    | waarde                      |
    | type    | NietBestaandVerblijfsobject |
    | periode | 2023-01-01 tot 2023-01-02   |
    En heeft de bewoning de volgende oudOfNieuwVerblijfsobjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010022197002                 |
