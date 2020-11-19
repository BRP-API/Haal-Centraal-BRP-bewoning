---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'BRP bewoning' Web API is gespecificeerd met behulp van de [OpenAPI specifications (OAS)](https://swagger.io/specification/).

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de functionaliteit en specificaties
2. Implementeer de API
3. Probeer en test de API

## Functionaliteit en specificaties
De bewoning API heeft functionaliteit waarmee:
* Je kan raadplegen welke personen op het opgegeven adres (adresseerbaar object) wonen of hebben gewoond
* Je kan raadplegen welke medebewoners de opgegeven persoon heeft (gehad)
* Je kan indicaties raadplegen voor verloop op het adres in de vorm van het aantal inverhuizingen en uitverhuizingen en het gemiddeld aantal bewoners

De bewoning API kan je op drie manieren gebruiken:
1. Met een peildatum. Je krijgt dan de (mede)bewoners op de opgegeven datum.
2. Met een periode (datumVan en datumTotEnMet). Je krijgt dan de (mede)bewoners of het verloop in de opgegeven periode.
3. Zonder peildatum of periode. Je krijgt dan alle (mede)bewoners of het totale verloop die bekend zijn/is in de registratie.

Het is mogelijk de gegevens van de ingeschreven personen die (mede)bewoners zijn direct mee te laden met gebruik van de [expand](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/v1.1.0/features/expand.feature) parameter.

Je kunt een visuele weergave van de specificatie inzien met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-BRP-bewoning/swagger-ui) of [Redoc](https://vng-realisatie.github.io/Haal-Centraal-BRP-bewoning/redoc).

De [functionele documentatie](./features) is beschreven in [features](./features).

## Implementeer de API

Je kunt code genereren op basis van de [genereervariant van de specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bewoning/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}.

## Probeer en test de API
Wil je de 'BRP bewoning' Web API proberen en testen? Kijk op: `https://www.haalcentraal.nl/haalcentraal/api/bewoning`

Om de web api te gebruiken heb je een apikey nodig. Deze voeg je aan een request toe als header "X-API-KEY". Een API-key vraag je aan bij de product owner [cathy.dingemanse@denhaag.nl](mailto:cathy.dingemanse@denhaag.nl).

__De Haal Centraal probeeromgeving gebruikt GBA-V op basis van de gemeentelijke autorisatie "Algemene gemeentetaken" voor buitengemeentelijke personen. Dit betekent dat de GBA-V niet alle gegevens teruggeeft die in de response zijn gedefinieerd. In de [API mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"} kun je zien welke gegevens wel of niet onder deze autorisatie vallen.__

__Je kan de Haal Centraal probeeromgeving niet gebruiken vanuit de browser, dus ook niet vanuit de browserversie van Postman. Gebruik dus de desktopversie van een testtool (zoals Postman) om berichten te sturen.__

### Importeer de specificaties in Postman

De werking van de API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/){:target="_blank" rel="noopener"}. We hebben al een [Postman collection](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bewoning/blob/master/test/BRP-Historie-Bevragen-postman-collection.json){:target="_blank" rel="noopener"} voor je klaargezet. Deze kun je importeren in Postman. 

### Configureer de url en api key

1. Klik bij "BRP bewoning" op de drie bolletjes.
2. Klik vervolgens op Edit
3. Selecteer tabblad "Authorization"
4. Kies TYPE "API Key"
5. Vul in Key: "x-api-key", Value: de API key die je van Cathy hebt ontvangen, Add to: "Header"
6. Selecteer tabblad "Variables"
7. Vul bij baseUrl INITIAL VALUE en bij CURRENT VALUE: `https://www.haalcentraal.nl/haalcentraal/api/bewoning`
8. Klik op de knop Update

### Testpersonen

Onderstaande tabel bevat de burgerservicenummers van testpersonen voor specifieke situaties waarmee de 'BRP bewoning' Web API kan worden getest.

burgerservicenummer | situatie
---------------- | :-------  
999993872 | meerdere medebewoners
999992740 | medebewoners met familierelatie
999991292 | medebewoners niet gerelateerd

De API gebruikt de GBA-V proefomgeving. Alle testpersonen die daarin voorkomen kun je ook in de API gebruiken. De volledige set testpersonen kan worden gedownload bij de [RvIG](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v){:target="_blank"}.
Een vertaling van GBA-V (LO GBA) attributen naar BRP API properties staat beschreven in de [BRP-LO GBA mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true){:target="_blank" rel="noopener"}.
