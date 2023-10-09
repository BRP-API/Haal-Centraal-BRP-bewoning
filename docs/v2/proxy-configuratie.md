---
layout: page-with-side-nav
title: Configureren van de {{ site.apiname }} Proxy
---

# {{ site.apiname }} Proxy configuratie

De volgende settings van de {{ site.apiname }} Proxy kunnen worden aangepast:

- [Routering](#routering)
- [Logging](#logging)
- [mTLS](#mtls)

## Routering

Standaard is de {{ site.apiname }} Proxy geconfigureerd om bevragingen door te sturen naar de mock van de {{ site.apiname }} Web API GBA variant.

De __Downstream__ configuratie van de {{ site.apiname }} Proxy moet worden aangepast om bevragingen door te sturen naar een andere instantie van de {{ site.apiname }} Web API GBA variant.

### Wijzigen van de Downstream configuratie van de Proxy (Docker Compose variant)

De volgende environment variabelen moet worden opgenomen in de configuratie van de Proxy in het [docker compose bestand]({{ site.mainBranchUrl }}/docker-compose.yml){:target="_blank" rel="noopener"}:

- Routes__0__DownstreamScheme. Het communicatieprotocol dat moet worden gebruikt voor het aanroepen van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Host. De host naam van de aan te roepen {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Port. De port nummer van de aan te roepen  {{ site.apiname }} Web API GBA variant

In het volgende voorbeeld is de Proxy geconfigureerd om bevragingen door te sturen naar de proef omgeving van de {{ site.apiname }} Web API GBA variant

```yaml

  bewoningproxy:
    container_name: bewoningproxy
    image: ghcr.io/brp-api/haal-centraal-bewoning-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
      - Routes__0__DownstreamScheme=https
      - Routes__0__DownstreamHostAndPorts__0__Host=proefomgeving-gba.haalcentraal.nl
      - Routes__0__DownstreamHostAndPorts__0__Port=443
    ports:
      - "5003:5000"
    networks:
      - bewoningen-api-network

```

Een andere mogelijkheid is om de routering configuratie te definieren in een json bestand en met behulp van een volume mount te monteren aan een container instantie.

In het volgende voorbeeld is de configuratie van de routering naar de proef omgeving van de {{ site.apiname }} Web API GBA variant gespecificeerd. Dit [configuratie bestand]({{ site.mainBranchUrl }}/src/config/BewoningProxy/configuration/ocelot.json){:target="_blank" rel="noopener"} is ook te vinden in de {{ site.apiname }} GitHub repository.

```json

{
  "Routes": [
    {
      "UpstreamPathTemplate": "/haalcentraal/api/bewoning/bewoningen",
      "DownstreamPathTemplate": "/haalcentraal/api/bewoning/bewoningen",
      "DownstreamScheme": "https",
      "DownstreamHostAndPorts": [
        {
          "Host": "proefomgeving-gba.haalcentraal.nl",
          "Port": "443"
        }
      ]
    }
  ]
}

```

Het configuratie bestand wordt vervolgens met behulp van een volume mount gemonteerd aan een {{ site.apiname }} Proxy instantie. In onderstaand voorbeeld wordt het ocelot.json bestand in de src/config/BewoningProxy/configuration map gemonteerd aan een {{ site.apiname}} Proxy instantie.

```yaml

  bewoningproxy:
    container_name: bewoningproxy
    image: ghcr.io/brp-api/haal-centraal-bewoning-bevragen-proxy:latest
    environment:
      - ASPNETCORE_ENVIRONMENT=Release
      - ASPNETCORE_URLS=http://+:5000
    ports:
      - "5003:5000"
    volumes:
      - ./src/config/BewoningProxy/configuration/ocelot.json:/app/configuration/ocelot.json
    networks:
      - bewoningen-api-network

```

### Wijzigen van de Downstream configuratie van de Proxy (Kubernetes variant)

De volgende environment variabelen moet worden opgenomen in de configuratie van de Proxy in het [bewoning proxy deployment bestand]({{ site.mainBranchUrl }}/.k8s/proxy-deployment.yml){:target="_blank" rel="noopener"}:

- Routes__0__DownstreamScheme. Het communicatieprotocol dat moet worden gebruikt voor het aanroepen van de {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Host. De host naam van de aan te roepen {{ site.apiname }} Web API GBA variant
- Routes__0__DownstreamHostAndPorts__0__Port. De port nummer van de aan te roepen {{ site.apiname }} Web API GBA variant

In het volgende voorbeeld is de Proxy geconfigureerd om bevragingen door te sturen naar de proef omgeving van de {{ site.apiname }} Web API GBA variant

```yaml

      containers:
        - name: bewoningproxy
          image: ghcr.io/brp-api/haal-centraal-bewoning-bevragen-proxy:latest
          env:
            - name: ASPNETCORE_ENVIRONMENT
              value: Release
            - name: ASPNETCORE_URLS
              value: http://+:5000
            - name: Routes__0__DownstreamScheme
              value: https
            - name: Routes__0__DownstreamHostAndPorts__0__Host
              value: proefomgeving-gba.haalcentraal.nl
            - name: Routes__0__DownstreamHostAndPorts__0__Port
              value: "443"
          ports:
            - name: http
              containerPort: 5000

```
