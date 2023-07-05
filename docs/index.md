---
layout: page-with-side-nav
title: Haal Centraal BRP-bewoning
---
# Haal Centraal BRP bewoning

![lint oas](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/workflows/lint-oas/badge.svg)
![generate postman collection](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/workflows/generate-postman-collection/badge.svg)

API voor het raadplegen van de (historische) bewoning(en) van een adres. Met de API kun je de samenstelling(en) van bewoners van een adres raadplegen op peildatum en periode.

## Planning & Roadmap
Het RvIG team werkt op dit moment nog aan de API. Binnenkort kun je hier net als bij de Personen API een docker compose bestand vinden om met Docker Desktop de bewoningProxy en de mock van de ‘bewoning’ Web API GBA variant te draaien op jouw eigen machine. Hiermee kun je onze MVP voor raadplegen op peildatum alvast uitproberen. Wij werken dan verder aan het raadplegen op periode, maar hebben ook tijd om zaken te verbeteren. Wij horen graag jullie ervaringen!
De bewoning API gaat op 1 oktober in productie.

## Direct uitproberen?
* Bekijk de specificaties met [Swagger UI](swagger-ui) of [Redoc](redoc)
* Lees de [Getting started](getting-started)
* Download de [technische specificaties](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}

## Heb je meer nodig? 
Gebruik de BRP bewoning API in combinatie met (een van de) andere BRP API’s:

* [Actuele BRP-gegevens bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bevragen){:target="_blank" rel="noopener"}
* [Historische BRP-gegevens bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-historie-bevragen){:target="_blank" rel="noopener"}
* [Reisdocumenten bevragen](https://BRP-API.github.io/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}
* [Landelijke tabellen bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-tabellen-bevragen){:target="_blank" rel="noopener"}

## Bronnen

* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Bug Melden
  [Maak een bug issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Maak een verbeter issue aan >>](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [cathy.dingemanse@rvig.nl](mailto:cathy.dingemanse@rvig.nl)
* Customer zero en ontwikkelaar: Melvin Lee, [melvin.lee@iswish.nl](mailto:melvin.lee@iswish.nl)
* Tester: Frank Samwel, [frank.samwel@rvig.nl](mailto:frank.samwel@rvig.nl)


