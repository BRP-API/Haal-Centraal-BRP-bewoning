---
layout: page-with-side-nav
title: Haal Centraal BRP-bewoning
---
# Haal Centraal BRP bewoning

![lint oas](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/workflows/lint-oas/badge.svg)
![generate postman collection](https://github.com/BRP-API/Haal-Centraal-BRP-Bewoning/workflows/generate-postman-collection/badge.svg)

API voor het raadplegen van de historische bewoning van een adres. Met de API kun je de samenstelling(en) van bewoners van een woning raadplegen binnen een periode of op een peildatum.

## Planning & Roadmap
De BRP Bewoning API v2 is live sinds november 2023. 

## Aansluiten en voorwaarden
De BRP Bewoning API kan voorlopig alleen worden gebruikt door gemeenten die deelnemen aan het [Experiment Dataminimalisatie](https://www.rijksoverheid.nl/documenten/besluiten/2023/08/28/experimentbesluit-brp-dataminimalisatie-amvb-nvt-versie-voorhang). Hiervoor wordt een convenant met RvIG gesloten waarin de afspraken voor deelname zijn vastgelegd. Voor de technische aansluiting is een API Gateway nodig. Aansluiten kan via Diginetwerk met gebruik van een TLS verbinding (PKIO certificaat) en een OAuth 2.0 token (OAuth 2.0 client credentials flow).

Stuur een email naar info@RvIG voor een kennismakingmakingsgesprek en onboarding. [Download]({{ site.onboardingUrl }}){:target="_blank" rel="noopener"} en lees het onboardingproces.

## Direct uitproberen?
* Bekijk de specificaties met [Redoc](https://brp-api.github.io/Haal-Centraal-BRP-bewoning/v2/redoc)
* Lees de [Getting started](https://brp-api.github.io/Haal-Centraal-BRP-bewoning/v2/getting-started)
  
## Heb je meer nodig? 
Gebruik de BRP bewoning API in combinatie met (een van de) andere BRP API’s:

* [Personen bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-bevragen){:target="_blank" rel="noopener"}
* [Historie bevragen](https://BRP-API.github.io/Haal-Centraal-BRP-historie-bevragen){:target="_blank" rel="noopener"}
* [Reisdocumenten bevragen](https://BRP-API.github.io/Haal-Centraal-Reisdocumenten-bevragen){:target="_blank" rel="noopener"}

## Bronnen

* [API Design Visie](https://github.com/Geonovum/KP-APIs/blob/master/overleggen/Werkgroep%20API%20design%20visie/API%20Design%20Visie.md){:target="_blank" rel="noopener"}
* [REST API Design Rules](https://docs.geostandaarden.nl/api/API-Designrules/){:target="_blank" rel="noopener"}
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/){:target="_blank" rel="noopener"}

## Contact

* Bug Melden
  [Geef een bug door >>](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/issues/new?assignees=&labels=bug&template=bug_report.md&title=)
* Verbeteringen doorgeven
  [Geef een verbetering door >>](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/issues/new?assignees=&labels=enhancement&template=enhancement.md&title=)

* Product Owner: Cathy Dingemanse, [{{ site.PO-email }}](mailto:{{ site.PO-email }})
* Customer zero: Melvin Lee, [{{ site.CZ-email }}](mailto:{{ site.CZ-email }})
* Tester: Frank Samwel, [{{ site.Tester-email }}](mailto:{{ site.Tester-email }})


