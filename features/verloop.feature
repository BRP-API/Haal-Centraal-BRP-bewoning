# language: nl
Functionaliteit: Verhuisbewegingen op een adres binnen een bepaalde periode

    Als medewerker vergunningen
    wil ik het aantal verhuisbewegingen weten op een adres binnen een bepaalde periode
    zodat ik onregelmatigheden op een adres kan signaleren bij het verlenen van een vergunning

    - Meerdere inschrijvingen op dezelfde datum tellen mee als één inschrijving
    - Meerdere uitschrijvingen op dezelfde datum tellen mee als één uitschrijving

Achtergrond:
    Gegeven een adresseerbaar object met identificatie 1234

Abstract Scenario: één inschrijving op een specifiek adres binnen de opgegeven periode
    En 1 inschrijving(en) op het adresseerbaar object op <inschrijfdatum>
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 1
    En is het aantal uitverhuizingen gelijk aan 0

    Voorbeelden:
    | inschrijfdatum | omschrijving |
    | 14-12-2020     | een datum binnen de opgegeven periode |
    | 01-12-2020     | de datum valt op de eerste dag van de opgegeven periode |
    | 31-12-2020     | de datum valt op de laatste dag van de opgegeven periode |

Scenario: meerdere inschrijvingen op een specifiek adres binnen de opgegeven periode
    En 1 inschrijving(en) op het adresseerbaar object op 14-12-2020
    En 1 inschrijving(en) op het adresseerbaar object op 16-12-2020
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 2
    En is het aantal uitverhuizingen gelijk aan 0

Scenario: meerdere inschrijvingen op één datum op een specifiek adres binnen de opgegeven periode
    En 3 inschrijving(en) op het adresseerbaar object op 16-12-2020
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 1
    En is het aantal uitverhuizingen gelijk aan 0

Abstract Scenario: één uitschrijving op een specifiek adres binnen de opgegeven periode
    En 1 uitschrijving(en) op het adresseerbaar object op <uitschrijfdatum>
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 0
    En is het aantal uitverhuizingen gelijk aan 1

    Voorbeelden:
    | uitschrijfdatum | omschrijving |
    | 14-12-2020     | een datum binnen de opgegeven periode |
    | 01-12-2020     | de datum valt op de eerste dag van de opgegeven periode |
    | 31-12-2020     | de datum valt op de laatste dag van de opgegeven periode |

Scenario: meerdere uitschrijvingen op een specifiek adres binnen de opgegeven periode
    En 1 uitschrijving(en) op het adresseerbaar object op 14-12-2020
    En 1 uitschrijving(en) op het adresseerbaar object op 16-12-2020
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 0
    En is het aantal uitverhuizingen gelijk aan 2

Scenario: meerdere uitschrijvingen op één datum op een specifiek adres binnen de opgegeven periode
    En 3 uitschrijving(en) op het adresseerbaar object op 16-12-2020
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 0
    En is het aantal uitverhuizingen gelijk aan 1
