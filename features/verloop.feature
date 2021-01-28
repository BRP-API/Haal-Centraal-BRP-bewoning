# language: nl
Functionaliteit: Verhuisbewegingen op een adresseerbaar object binnen een bepaalde periode

    Als medewerker vergunningen
    wil ik het aantal verhuisbewegingen weten op een adres binnen een bepaalde periode
    zodat ik onregelmatigheden op een adres kan signaleren bij het verlenen van een vergunning

    - Meerdere bewoners met dezelfde datum aanvang adreshouding tellen mee als één 'in verhuizing'
    - Meerdere bewoners met dezelfde datum tot tellen mee als één 'uit verhuizing'

Achtergrond:
    Gegeven een adresseerbaar object met identificatie 1234

Abstract Scenario: één bewoner op een specifiek adresseerbaar object met datum aanvang adreshouding binnen de opgegeven periode
    En er is 1 bewoner met datum aanvang adreshouding '<datum aanvang adreshouding>' op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 1
    En is het aantal uitverhuizingen gelijk aan 0

    Voorbeelden:
    | datum aanvang adreshouding | omschrijving |
    | 14-12-2020                 | datum aanvang adreshouding valt binnen de opgegeven periode |
    | 01-12-2020                 | datum aanvang adreshouding valt op de eerste dag van de opgegeven periode |
    | 31-12-2020                 | datum aanvang adreshouding valt op de laatste dag van de opgegeven periode |

Scenario: meerdere bewoners op een specifiek adresseerbaar object met datum aanvang adreshouding binnen de opgegeven periode
    En er is 1 bewoner met datum aanvang adreshouding '14-12-2020' op het adresseerbaar object
    En er is 1 bewoner met datum aanvang adreshouding '16-12-2020' op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 2
    En is het aantal uitverhuizingen gelijk aan 0

Scenario: meerdere bewoners op een specifiek adresseerbaar object met dezelfde datum aanvang adreshouding binnen de opgegeven periode
    En er zijn 3 bewoners met datum aanvang adreshouding '16-12-2020' op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 1
    En is het aantal uitverhuizingen gelijk aan 0

Abstract Scenario: één bewoner op een specifiek adresseerbaar object met datum tot binnen de opgegeven periode
    En er is 1 bewoner met datum tot '<datum tot>' op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 0
    En is het aantal uitverhuizingen gelijk aan 1

    Voorbeelden:
    | datum tot  | omschrijving |
    | 14-12-2020 | datum tot valt binnen de opgegeven periode |
    | 01-12-2020 | datum tot valt op de eerste dag van de opgegeven periode |
    | 31-12-2020 | datum tot valt op de laatste dag van de opgegeven periode |

Scenario: meerdere bewoners op een specifiek adresseerbaar object met datum tot binnen de opgegeven periode
    En er is 1 bewoner met datum tot '14-12-2020' op het adresseerbaar object
    En er is 1 bewoner met datum tot '16-12-2020' op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 0
    En is het aantal uitverhuizingen gelijk aan 2

Scenario: meerdere bewoners op een specifiek adresseerbaar object met dezelfde datum tot binnen de opgegeven periode
    En er zijn 3 bewoners met datum tot '16-12-2020' op het adresseerbaar object
    Als voor adresseerbaar object met identificatie 1234 het verloop tussen 01-12-2020 en 31-12-2020 wordt bevraagd
    Dan is het aantal inverhuizingen gelijk aan 0
    En is het aantal uitverhuizingen gelijk aan 1
