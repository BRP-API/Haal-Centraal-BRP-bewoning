#language: nl

@gba
Functionaliteit: raadpleeg bewoning met infrastructurele of technische wijziging

  Als consumer van de Bewoning API
  wil ik bij het opvragen van bewoning voor een technisch of infrastructureel gewijzigde adresseerbaar object dat de ingangsdatum van een wijziging niet wordt gebruikt als datum aanvang adreshouding
  zodat ik correct kan bepalen wanneer een persoon bewoner is van het gevraagde adresseerbaar object

  Als consumer van de Bewoning API
  wil ik wanneer er geen bewoning kan worden bepaald voor een adresseerbaar object dat is gewijzigd door samenvoeging of splitsing de identificatie van de oorspronkelijke of nieuwe adresseerbaar objecten
  zodat ik geen andere bronnen hoeft te raadplegen om de bewoning van de oorspronkelijke of nieuwe adresseerbaar objecten te kunnen opvragen

  Het technisch of infrastructureel wijzigen van een adresseerbaar object wordt in de BRP geregistreerd als een nieuw adres.
  De inschrijving van een persoon op een adresseerbaar object wordt in de BRP geregistreerd met behulp van een verblijfplaats voorkomen.
  Wanneer een adresseerbaar object technisch of infrastructureel wordt gewijzigd en er zijn actuele inschrijvingen op het adresseerbaar object,
  dan wordt voor elke actuele inschrijving een nieuw verblijfplaats voorkomen geregistreerd met een verwijzing naar het nieuwe adres.
  Bij het nieuwe verblijfplaats voorkomen wordt ook geregistreerd:
  - aangifte adreshouding (72.10) met waarde T (technische wijziging) of W (infrastructurele wijziging)
  - datum aanvang adreshouding (10.30) met de datum waarop de nieuwe verblijfplaats is geregistreerd
  Technische wijzigingen zijn:
  - het toevoegen van identificatiecodes aan een niet-BAG adres
  Infrastructurele wijzigingen zijn:
  - hernummering van een adresseerbaar object
  - herindeling van een adresseerbaar object
  - samenvoegen van adresseerbaar objecten
  - splitsen van een adresseerbaar object

Rule: Bij een verblijfplaats voorkomen dat is geregistreerd naar aanleiding van wijzigingen aan het gekoppeld adresseerbaar object, moet de werkelijke datum aanvang adreshouding worden gehaald bij een vorig verblijfplaats voorkomen

  Abstract Scenario: bewoning wordt gevraagd van een hernummerd adresseerbaar object en <omschrijving>
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

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat na herindeling in een andere gemeente is komen te liggen en <omschrijving>
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

Rule: Wanneer een adresseerbaar object in een periode geen adresseerbaar object identificatie heeft, dan wordt er voor die periode geen bewoning geleverd (bewoning onbekend)

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object waaraan BAG identificaties zijn toegevoegd en <omschrijving>
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

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object waaraan BAG identificaties zijn toegevoegd en <omschrijving>
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
    | naam    | waarde           |
    | type    | BewoningOnbekend |
    | periode | <periode>        |

    Voorbeelden:
    | peildatum  | periode                   | omschrijving                                                |
    | 2022-04-30 | 2022-04-30 tot 2022-05-01 | peildatum is de dag vóór datum toevoegen BAG identificaties |
    | 2022-01-01 | 2022-01-01 tot 2022-01-02 | peildatum ligt vóór datum toeovoegen BAG identificaties     |

Rule: bevragen van bewoning van een adresseerbaar object dat is ontstaan uit een samengevoeging op een datum vóór de samenvoeging levert (als dit kan worden bepaald) de identificatie van de samengevoegde adresseerbaar objecten

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit een samenvoeging en peildatum ligt vóór de samenvoeging
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2022-01-01 tot 2022-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit een samenvoeging en peildatum ligt na de samenvoeging
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

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit samenvoeging en de bewoners zijn gaan samenwonen en de peildatum ligt vóór datum samenvoeging
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2022-01-01 tot 2022-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |
    | 0800010022197002                 |

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit samenvoeging en de bewoners zijn gaan samenwonen en de peildatum ligt na datum samenvoeging
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

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit een samenvoeging en de bewoners van een samengevoegd adresseerbaar object verhuizen niet naar het nieuwe adresseerbaar object en de peildatum ligt vóór datum samenvoeging
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2022-01-01 tot 2022-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |

Rule: bevragen van bewoning van een adresseerbaar object dat is overgegaan in een samengevoeging op een datum na de samengevoeging levert (als dit kan worden bepaald) de identificatie van het adresseerbaar object dat is ontstaan uit samenvoeging

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is overgegaan in een samenvoeging en peildatum ligt vóór datum samenvoeging
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

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is overgegaan in een samenvoeging en de peildatum ligt vóór datum samenvoeging
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

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is overgegaan in een samenvoeging en peildatum ligt na de samenvoeging
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2023-01-01 tot 2023-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010022197002                 |

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is overgegaan in een samenvoeging en de bewoners zijn niet ingeschreven in het samengevoegd adresseerbaar object en peildatum ligt na datum samenvoeging
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2023-01-01 tot 2023-01-02    |
    En heeft de bewoning geen oudeOfNieuweAdresseerbaarObjecten

Rule: bevragen van bewoning van een adresseerbaar object dat is ontstaan uit een splitsing op een datum vóór de splitsing levert (als dit kan worden bepaald) de identificatie van het gesplitste adresseerbaar object

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit splitsing en de peildatum ligt vóór datum splitsing
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2022-01-01 tot 2022-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010011067001                 |

    Voorbeelden:
    | adresseerbaar object identificatie |
    | 0800010022197002                   |
    | 0800010022192003                   |

  Abstract Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is ontstaan uit splitsing en er zijn geen oorspronkelijke bewoners ingeschreven op het adresseerbaar object en de peildatum ligt vóór datum splitsing
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2022-01-01 tot 2022-01-02    |
    En heeft de bewoning geen oudeOfNieuweAdresseerbaarObjecten

    Voorbeelden:
    | adresseerbaar object identificatie |
    | 0800010022197002                   |
    | 0800010022192003                   |

Rule: bevragen van bewoning van een adresseerbaar object dat is gesplitst op een datum na de splitsing levert (als dit kan worden bepaald) de identificatie van de adresseerbaar objecten die uit de splitsing zijn ontstaan

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is gesplitst en de peildatum ligt na datum splitsing
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2023-01-01 tot 2023-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010022197002                 |
    | 0800010022192003                 |

  Scenario: bewoning wordt gevraagd van een adresseerbaar object dat is gesplitst en één van de uit splitsing ontstaan adresseerbaar object bevat geen bewoners van het gesplitste adresseerbaar object en de peildatum ligt na datum splitsing
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
    | naam    | waarde                       |
    | type    | GewijzigdAdresseerbaarObject |
    | periode | 2023-01-01 tot 2023-01-02    |
    En heeft de bewoning de volgende oudeOfNieuweAdresseerbaarObjecten
    | adresseerbaarObjectIdentificatie |
    | 0800010022197002                 |
