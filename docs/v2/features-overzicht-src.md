---
layout: page-with-side-nav
title: Features
---

# {{ site.apiname }} Web API Features

Met de {{ site.apiname }} Web API kun je de bewoning van een adresseerbaar object in een periode raadplegen. Bewoning kun je ophalen met de identificatie van een adresseerbaar object.

## Algemene Verordening Gegevensbescherming (AVG)

De '{{ site.apiname }}' Web API is ontworpen conform de REST principes. Om aan de AVG te conformeren zijn er concessies gedaan aan het toepassen van de REST principes. De belangrijkste concessie is dat de POST methode en niet de GET methode wordt gebruikt om bewoning te raadplegen. Dit zorgt er voor dat er geen [persoonlijk identificeerbare informatie (PII)](https://piwikpro.nl/blog/pii-niet-pii-en-persoonsgegevens/) terecht komt in de url van een request en daarmee ook niet in server logs. We anticiperen daarmee op het raadplegen van bewoningen van een persoon, die je in een volgende versie van de Bewoning API kunt ophalen met een BSN.

## Raadplegen van de bewoning van een adresseerbaar object

Met behulp van de 'raadpleeg bewoning met periode' operatie wordt voor een adresseerbaar object de bewoning in een periode opgehaald.

Een bewoning geeft de samenstelling van de bewoners in een periode op een adresseerbaar object weer. De response van een bevraging bevat meerdere bewoningen als de samenstelling van de bewoners in de gevraagde periode is wijzigd.

Een persoon is en was bewoner van een adresseerbaar object als hij volgens de BRP registratie is/was ingeschreven op het adresseerbaar object in de gevraagde periode. De bewoning/adreshouding periode begint op de **datum aanvang adreshouding** van de inschrijving op het adresseerbaar object en eindigt (indien aanwezig) op de **datum aanvang adreshouding** van de volgende inschrijving of op de **datum aanvang adres buitenland** als de persoon is geëmigreerd.

Een persoon is in een gevraagde periode bewoner als de gevraagde periode in de adreshouding periode van de persoon ligt. Overlapt de gevraagde periode geheel of deels de adreshouding van de persoon, dan wordt de persoon alleen voor het overlappende gedeelte van de gevraagde periode als bewoner meegenomen.

Onderstaand stroomdiagram illustreert de beslisboom voor het bepalen of een persoon is ingeschreven op het adresseerbaar object in de gevraagde periode, of voor een deel van de gevraagde periode wordt meegenomen als bewoner. De datum aanvang (volgende) adreshouding is in deze beslisboom niet geheel of gedeeltelijk onbekend.

```mermaid
flowchart LR

A["Bepaal bewoning
van persoon
in periode"]
A --> A1

A1{{"is datumTot <=
datum aanvang adreshouding?"}}
A1 -- ja -----> GB-VDA
A1 -- nee --> A2

    A2{{"heeft persoon
    volgende adreshouding?"}}
    A2 -- nee ---> A3
    A2 -- ja --> A4

        A3[bewoner]
        A3 -- "datumVan >=
        datum aanvang
        adreshouding" --> IB-NDA
        A3 -- "datumVan <
        datum aanvang
        adreshouding" --> IB-ODA

        A4{{"is datumVan >=
        datum aanvang
        volgende adreshouding?"}}
        A4 -- ja ---> GB-NDA-NVDA
        A4 -- nee --> A5

            A5[bewoner]
            A5 -- "gevraagde periode
            ligt in
            adreshouding periode" --> WB-NDA-VDAV
            A5 -- "datumVan < datum aanvang
            adreshouding en datumTot
            ligt in adreshouding periode" --> WB-ODA
            A5 -- "datumVan ligt in adreshouding periode
            en datumTot > datum aanvang
            volgend adreshouding" --> WB-ODAV
            A5 -- "adreshouding periode
            ligt
            gevraagde periode" --> WB-ODA-ODAV

GB-VDA["geen bewoner
(GB-VDA)"]
%% gevraagde periode eindigt op/vóór datum aanvang adreshouding %%

GB-NDA-NVDA["geen bewoner
(GB-NDA-NVDA)"]
%% gevraagde periode begint op/na datum aanvang volgende adreshouding %%

IB-NDA["bewoner
(IB-NDA)"]
%% gevraagde periode ligt in adreshouding periode (datumVan - datumTot)

IB-ODA["bewoner
(IB-ODA)"]
%% datumTot valt in adreshouding periode (datum aanvang adreshouding - datumTot) %%

WB-NDA-VDAV["bewoner
(WB-NDA-VDAV)"]
%% gevraagde periode ligt in adreshouding periode (datumVan - datumTot) %%

WB-ODA["bewoner
(WB-ODA)"]
%% gevraagde periode overlapt datum aanvang adreshouding (datum aanvang adreshouding - datumTot) %%

WB-ODAV["bewoner
(WB-ODAV)"]
%% gevraagde periode overlapt datum aanvang volgende adreshouding (datumVan - datum aanvang volgende adreshouding) %%

WB-ODA-ODAV["bewoner
(WB-ODA-ODAV)"]
%% adreshouding periode ligt in gevraagde periode (datum aanvang adreshouding - datum aanvang volgende adreshouding) %%
```
