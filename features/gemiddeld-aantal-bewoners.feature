# language: nl
Functionaliteit: Gemiddeld aantal bewoners op een adresseerbaar object binnen een bepaalde periode

    Gemiddelde bewoning van een persoon in een periode = aantal dagen adreshouding in periode / aantal dagen in periode
    Gemiddeld aantal bewoners in een periode = som van gemiddelde bewoning per persoon in de periode

    bewoners met geheel- en gedeeltelijk onbekend datum aanvang adreshouding of 'datum tot' wordt niet meegenomen bij het bepalen van verloop

Achtergrond:
    Gegeven een adresseerbaar object met identificatie 1234
    En de bewoners op het adresseerbaar object
    | bewoner | datum aanvang adreshouding | datum tot  |
    | 1       | 15-08-2007                 | 01-01-2021 |
    | 2       | 04-03-2010                 |            |
    | 3       | 27-11-2019                 |            |
    | 4       | 11-12-2020                 |            |

Scenario: één bewoner, aantal dagen adreshouding is gelijk aan aantal dagen bereken periode
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-01-2008 en 31-12-2008 wordt bevraagd
    Dan is het gemiddeld aantal bewoners gelijk aan 1

Scenario: één bewoner, aantal dagen adreshouding is kleiner daan aantal dagen bereken periode
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-08-2007 en 31-10-2007 wordt bevraagd
    Dan is het gemiddeld aantal bewoners gelijk aan 0.8478
    # aantal dagen bewoning (17+30+31) / aantal dagen maand (31+30+31) = 0.848

Scenario: meerdere bewoners
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het gemiddeld aantal bewoners gelijk aan 3.6774
    # (bewoner1: 31 + bewoner2: 31 + bewoner3: 31 + bewoner4: 21)/31 = 3.6774

Scenario: open begin bereken periode
    Als voor adresseerbaar object met identificatie 1234 het verloop tot en met 31-12-2020 wordt bevraagd
    Dan is voor datumVan 15-08-2007 genomen
    # datumVan = datum aanvang adreshouding eerste bewoner
    En is het gemiddeld aantal bewoners gelijk aan 1.8957
    # bewoner1: 4888/4888 + bewoner2: 3956/4888 + bewoner3: 401/4888 + bewoner4: 21/4888

Scenario: open einde bereken periode
    Gegeven vandaag is 28-01-2021
    Als voor adresseerbaar object met identificatie 1234 het verloop vanaf 01-12-2020 wordt bevraagd
    Dan is voor datumTotEnMet 28-01-2021 genomen
    # datumTotEnMet = datum vandaag
    En is het gemiddeld aantal bewoners gelijk aan 3.3621
    # bewoner1: 31/58 + bewoner2: 58/58 + bewoner3: 58/58 + bewoner4: 48/58


Abstract Scenario: een bewoner op een specifiek adresseerbaar object met geheel of gedeeltelijk onbekend datum aanvang adreshouding binnen de opgegeven periode
    En er is 1 bewoner met jaar '<jaar>', maand '<maand>', dag '<dag>' voor datum aanvang adreshouding op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-01-2021 en 31-01-2021 wordt bevraagd
    Dan is het gemiddeld aantal bewoners gelijk aan 0

    Voorbeelden:
    | jaar | maand | dag | omschrijving                                         |
    |      |       |     | geheel onbekend datum aanvang adreshouding           |
    | 2021 |       |     | datum aanvang adreshouding met onbekend dag en maand |
    | 2021 | 1     |     | datum aanvang adreshouding met onbekend maand        |

Abstract Scenario: een bewoner op een specifiek adresseerbaar object met geheel of gedeeltelijk onbekend datum tot binnen de opgegeven periode
    En er is 1 bewoner met jaar '<jaar>', maand '<maand>', dag '<dag>' voor datum tot op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het gemiddeld aantal bewoners gelijk aan 0

    Voorbeelden:
    | jaar | maand | dag | omschrijving                        |
    |      |       |     | geheel onbekend datum tot           |
    | 2021 |       |     | datum tot met onbekend dag en maand |
    | 2020 | 1     |     | datum tot met onbekend maand        |
