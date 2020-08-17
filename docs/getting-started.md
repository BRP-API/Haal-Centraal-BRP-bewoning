# Getting Started

De 'Bevraging bewoning' Web API is gespecificeerd met behulp van de OpenAPI specifications (OAS).

## Specificaties
Een visuele representatie van de specificatie kan worden gegenereerd met [Swagger UI](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-BRP-bewoning/master/specificatie/openapi.yaml).

De (resolved) OAS3 is hier te downloaden: [openapi.yaml](../specificatie/genereervariant/openapi.yaml).


## Functionaliteit
De API heeft 3 endpoints:
| /bewoningen?burgerservicenummer={burgerservicenummer} | Medebewoners | Hiermee kun je raadplegen welke medebewoners  de opgegeven persoon heeft(gehad) |
| /bewoningen/{identificatiecodenummeraanduiding} | Bewoners | Hiermee kun je raadplegen welke bewoners op het opgegeven adres wonen of hebben gewoond |
| /bewoningen/{identificatiecodenummeraanduiding}/verloop | Verloop | Hiermee krijg je indicaties voor verloop op het adres in de vorm van het aantal inverhuizingen en uitverhuizingen en het gemiddeld aantal bewoners |

Op elk van de drie endpoints kan een periode worden opgegeven met parameters "datumvan" en "datumtotenmet". De bewoners en medebewoners kunnen ook worden gevraagd op een specifieke datum met parameter "peildatum".

De 'Bevraging Ingeschreven Persoon' Web API maakt gebruik van de HAL (Hypertext Application Language) standaard om bij een resource links op te nemen naar gerelateerde resources en/of om bij een resource gerelateerde resources op te nemen (embedden).  

Het is mogelijk om alleen specifieke kenmerken van een bewoning te bevragen met behulp van de [fields](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/v1.1.0/features/fields.feature) Query Parameter.

Het is mogelijk de gegevens van de ingeschreven personen die (mede)bewoners zijn direct mee te laden met gebruik van de [expand](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/v1.1.0/features/expand.feature) parameter.

## Probeer en test de API
De Bewoning Web API is te benaderen via de volgende url: https://www.haalcentraal.nl/haalcentraal/api/brp

Om de web api te kunnen bevragen is een apikey nodig. Deze kun je aanvragen door een e-mail te sturen naar Cathy Dingemanse <c.dingemanse@comites.nl>.

### Testen met Postman
De werking van de 'Bevraging Ingeschreven Persoon' Web API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/). We hebben al een [Postman collection](../test/BRP-Bewoning-postman-collection.json) voor je klaargezet die je kan gebruiken.

Volg onderstaande stappen om de collection bestand te importeren:

1. Klik op de Import button om de Import dialog box te openen

2. Selecteer 'Import From Link' tab, plak de volgende url in de 'Enter a URL and press Import' textbox en klik op de Import button

``` url
https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-BRP-bewoning/master/test/BRP-Bewoning-postman-collection.json
```

3. Klik op de Next button om de Postman collectie te importeren

4. Voeg de API key toe
Selecteer het request waar je dit wilt toevoegen. In het rechterscherm wordt een invoerscherm voor de request getoond. Klik op het tabblad "Authorization". Kies type "API Key". Vul bij Value de API key in die je hebt gekregen.
5. Ga naar tabblad Params en vul de parameters in die je wilt gebruiken. Uncheck de overige parameters.

6. Vervang de {{baseUrl}} in de url met https://www.haalcentraal.nl/haalcentraal/api/brp en klik de Send button om de request naar de endpoint te sturen.

### Testgevallen
Onderstaand tabel bevat de burgerservicenummer van enkele test personen voor specifieke situaties waarmee werking van de 'Bewoning' Web API kan worden getest.

burgerservicenummer | situatie
---------------- | :-------  
999993872 | meerdere medebewoners
999992740 | medebewoners met familierelatie
999991292 | medebewoners niet gerelateerd

De API gebruikt de GBA-V proefomgeving. Alle testpersonen die daarin voorkomen kun je ook in de API gebruiken. De volledige set testpersonen kan worden gedownload bij de [RvIG](https://www.rvig.nl/documenten/richtlijnen/2018/09/20/testdataset-persoonslijsten-proefomgevingen-gba-v).
Een vertaling van GBBA-V (LO GBA) attributen naar BRP API properties staat beschreven in de [BRP-LO GBA mapping](https://github.com/VNG-Realisatie/Haal-Centraal-BRP-bevragen/blob/master/docs/BRP-LO%20GBA%20mapping.xlsx?raw=true).
