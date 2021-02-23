---
layout: page-with-side-nav
title: Haal Centraal BRP bewoning
---

# Releasenotes Haal-Centraal-BRP-Bewoning


## Versie 1.0.0

Alhoewel er nog geen eerdere officiële versie van de Haal-Centraal-BRP-bewoning API als release is uitgebracht is de specificatie het afgelopen jaar redelijk stabiel geweest. Die versie hebben we geborgd als v0.9.0
Voor het uitbrengen van release v1.0.0 is besloten om de nieuwe inzichten die het afgelopen jaar zijn opgedaan op te nemen. Hier een globaal overzicht van wijzigingen die doorgevoerd zijn voordat v1.0.0 is uitgebracht. Enkele van deze wijzigingen zijn breaking ten opzichte van v0.9.0.

We bieden nu ook SDK's aan met gegenereerde [plumbing-code](./code).
Daarnaast bieden we een[postman-collectie](./test) t.b.v. testen aan.

### Openapi.yaml:

_**Breaking**_

/bewoningen/{identificatiecodenummeraanduiding} --> /bewoningen/{adresseerbaarObjectIdentificatie}
- datumvan --> datumVan
- datumtotenmet --> datumTotEnMet
- raadplegen op basis van de parameter identificatiecodenummeraanduiding is aangepast naar raadplegen op basis van de parameter adresseerbaarObjectIdentificatie.

/bewoningen/{identificatiecodenummeraanduiding}/verloop --> /bewoningen/{adresseerbaarObjectIdentificatie}/verloop
- datumvan --> datumVan
- datumtotenmet --> datumTotEnMet
- Ook bij de subresource "verloop" is raadplegen op basis van de parameter identificatiecodenummeraanduiding voor de bewoning is aangepast naar raadplegen op basis van de parameter adresseerbaarObjectIdentificatie.

/bewoningen :
- datumvan --> datumVan
- datumtotenmet --> datumTotEnMet
- Zoeken met query-parameter identificatiecodenummeraanduiding) is vervallen en zoeken met query-parameter adresseerbaarObjectIdentificatie is toegevoegd


Schema:

- Verblijfplaats is aangepast door hergebruik van het BAG-adres
  - Verblijfplaats.straatnaam --> Verblijfplaats.korteNaam
  - Verblijfplaats.identificatiecodeNummeraanduiding --> Verblijfplaats.nummeraanduidingIdentificatie
  - Verblijfplaats.identificatiecodeAdresseerbaarObject --> Verblijfplaats.adresseerbaarObjectIdentificatie
  - Verblijfplaats.naamOpenbarerRuimte --> Verblijfplaats.straatnaam
  - Verblijfplaats.straatnaam --> Verblijfplaats.korteNaam
  - Verblijfplaats.woonplaatsnaam --> Verblijfplaats.woonplaats
  - VerblijfplaatsInOnderzoek.identificatiecodeNummeraanduiding --> VerblijfplaatsInOnderzoek.nummeraanduidingIdentificatie
  - VerblijfplaatsInOnderzoek.identificatiecodeAdresseerbaarObject --> VerblijfplaatsInOnderzoek.adresseerbaarObjectIdentificatie
  - VerblijfplaatsInOnderzoek.naamOpenbarerRuimte --> VerblijfplaatsInOnderzoek.straatnaam
  - VerblijfplaatsInOnderzoek.straatnaam --> VerblijfplaatsInOnderzoek.korteNaam
  - VerblijfplaatsInOnderzoek.woonplaatsnaam --> VerblijfplaatsInOnderzoek.woonplaats


- Bewoner.functieadres --> Bewoner.functieAdres
- Bewoning_links.nummeraanduiding --> BewoningLinks.nummeraanduidingen (Dit is een array geworden)
- IngeschrevenPersoon.nationaliteit --> IngeschrevenPersoon.nationaliteiten
- IngeschrevenPersoon.reisdocumenten --> IngeschrevenPersoon.reisdocumentnummers
- IngeschrevenPersoon_links.verblijfplaatsNummeraanduiding --> IngeschrevenPersoonLinks.adres


_**non-Breaking**_
- IngeschrevenPersoon_Links --> IngeschrevenPersoonLinks
- Schema-component BinnenlandsAdres is verwijderd.
- Schema-component Verblijfbuitenland is verwijderd. Properties zijn opgenomen in Verblijfplaats.
- SchemaComponent Bewoning : adresseerbaarobjectidentificatie toegevoegd
- Enkele namen van schema-componenten zijn aangepast vanwege consistentie met andere Haal-Centraal API's
  - Hal-componenten die alleen _links bevatten zijn omgenoemd van xxxHal naar xxxHalBasis
  - Bewoning_links --> BewoningLinks
  - Bewoning_embedded --> BewoningEmbedded
  - BewoningHalCollectie__embedded --> BewoningHalCollectieEmbedded
  - Datum_onvolledig --> DatumOnvolledig
  - Partner_links --> PartnerLinks
  - AangaanHuwelijkInOnderzoek --> AangaanHuwelijkPartnerschapInOnderzoek
  - IngeschrevenPersoon_links --> IngeschrevenPersoonLinks
  - IngeschrevenPersoon_embedded --> IngeschrevenPersoonEmbedded
- NaamPersoon.regelVoorafgaandAanAanschrijfwijze toegevoegd
- NaamPersoon.inOnderzoek toegevoegd
- Naam.adellijkeTitelPredikaat toegevoegd
- NaamInOnderzoek.adellijkeTitelPredikaat toegevoegd
- Bij properties zijn de maxLength, minLength, pattern en (waar overbodig) de title weggehaald.

### Features:

- gemiddeld-aantal-bewoners.feature is toegevoegd
- verloop.feature is toegevoegd
