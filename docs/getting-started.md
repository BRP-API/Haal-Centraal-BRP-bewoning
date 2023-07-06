---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'BRP bewoning' Web API is gespecificeerd in [OpenAPI specifications (OAS)](https://swagger.io/specification/).

Wil je de API gebruiken? Dit kun je doen:

1. Bekijk de [functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API Client](#implementeer-de-api-client)
3. [Probeer en test de API](#probeer-en-test-de-api)

## Functionaliteit en specificaties
Met de bewoning API kun je:
* de samenstelling van bewoners van een adres raadplegen op een peildatum 
* de samenstelling(en) van bewoners van een adres raadplegen en binnen een periode.

De bewoning API kun je op drie manieren gebruiken:
1. Met een peildatum. Je krijgt dan de bewoners van het adres op de opgegeven datum.
2. Met een periode (datumVan en datumTotEnMet). Je krijgt dan de samenstelling(en) van bewoners van het adres binnen de opgegeven periode.

Bekijk de OAS specificaties in [Redoc](https://brp-api.github.io/Haal-Centraal-BRP-bewoning/redoc-io)

## Implementeer de API client
Client code kun je genereren met de "[genereervariant](https://github.com/BRP-API/Haal-Centraal-BRP-bewoning/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties en een code generator. Een overzicht met codegeneratoren kun je vinden op [OpenAPI.Tools](https://openapi.tools/#sdk){:target="_blank" rel="noopener"}.

Deze repo bevat scripts waarmee je met [OpenAPI Generator](https://openapi-generator.tech/){:target="_blank" rel="noopener"} client code kunt genereren in JAVA, .NET (Full Framework & Core) en Python. De makkelijkste manier om de code generatie scripts te gebruiken, is door deze repo te clonen. Na het clonen kun je met `npm install` de benodigde packages installeren en kun je met npm run <script naam> één van de volgende scripts uitvoeren:
- oas:generate-java-client (voor JAVA client code)
- oas:generate-netcore-client (voor .NET Core client code)
- oas:generate-net-client (voor .NET Full Framework client code)
- oas:generate-python-client (voor Python client code)

Een lijst met andere ondersteunde generator opties kun je vinden in de [Generators List](https://openapi-generator.tech/docs/generators){:target="_blank" rel="noopener"} van OpenAPI Generator.

Note. De prerequisite van OpenAPI Generator is JAVA. Je moet een JAVA runtime installeren voordat je OpenAPI Generator kunt gebruiken
  
## Probeer en test de API
Volgt binnenkort


