---
layout: page-with-side-nav
title: Haal Centraal BRP-bewoning
---
# Haal Centraal BRP bewoning

![lint oas](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/workflows/lint-oas/badge.svg)
![generate postman collection](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/workflows/generate-postman-collection/badge.svg)

API voor het raadplegen van de (historische) bewoning(en) van een adres. Met de API kun je de samenstelling(en) van bewoners van een adres raadplegen op een peildatum en binnen een periode.

## Planning & Roadmap
Het team van RvIG werkt op dit moment nog aan v2 van de API. Binnenkort kun je hier net als bij de Personen API met behulp van een docker compose bestand de bewoningProxy en de mock van de GBA variant draaien op jouw eigen machine. Hiermee kun je onze MVP voor raadplegen op peildatum alvast uitproberen. Wij werken dan verder aan het raadplegen van bewoningen op periode, maar hebben ook tijd om de MVP te verbeteren. Wij horen graag jullie ervaringen!
De bewoning API v2 gaat op 1 oktober in productie, en kan voorlopig alleen worden gebruikt door gemeenten. 

## Direct uitproberen?
* Bekijk de specificaties met [Redoc](https://brp-api.github.io/Haal-Centraal-BRP-bewoning/redoc-io)
* Lees de [Getting started] (volgt binnenkort)
* Download de [technische specificaties](volgt binnenkort)

## Heb je meer nodig? 
Gebruik de BRP bewoning API in combinatie met (een van de) andere BRP API’s:

* [Personen bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bevragen){:target="_blank" rel="noopener"}
* [Historie bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-historie-bevragen){:target="_blank" rel="noopener"}
* [Reisdocumenten bevragen](https://BRP-API.github.io/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}
* [Landelijke tabellen bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-tabellen-bevragen){:target="_blank" rel="noopener"}
  
Maak je nog gebruik van versie 1.0? Bekijk de specificaties met [Swagger UI](https://brp-api.github.io/Haal-Centraal-BRP-bewoning/swagger-ui) of [Redoc](https://brp-api.github.io/Haal-Centraal-BRP-bewoning/redoc) en download de [technische specificaties](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/blob/master/specificatie/genereervariant/openapi.yaml)

## Bronnen

* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Bug Melden
  [Geef een bug door >>](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Geef een verbetering door >>](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [cathy.dingemanse@rvig.nl](mailto:cathy.dingemanse@rvig.nl)
* Customer zero en ontwikkelaar: Melvin Lee, [melvin.lee@iswish.nl](mailto:melvin.lee@rvig.nl)
* Tester: Frank Samwel, [frank.samwel@rvig.nl](mailto:frank.samwel@rvig.nl)


