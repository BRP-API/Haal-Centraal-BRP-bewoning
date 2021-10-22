# language: nl
Functionaliteit: Als gebruiker wil ik weten welke personen in een periode of peildatum op hetzelfde adres waren ingeschreven als een persoon
    medebewoners van een persoon kan worden gevraagd door bewoningen te zoeken op burgerservicenummer
    alle regels van de bewoning-paramters.feature en bewoners.feature en bewoning-adresssen,feature  gelden, tenzij daar hieronder van wordt afgeweken

    Rule: vragen van bewoningen op burgerservicenummer geeft de bewoning van alle verblijfplaatsen die betreffende persoon in de gevraagde periode ten minste één dag heeft gehad

        Scenario: persoon heeft meerdere verschillende verblijfplaatsen gehad in gevraagde periode
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01XXXXXXXXX2                         |
                | 58        | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXX1                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
            Als de bewoning wordt gevraagd op burgerservicenummer met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ4-M4-D4
            Dan bevat het antwoord 2 bewoningen
            En bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" de bewoners met burgerservicenummer "99999XXXX", "99999YYYY", "99999ZZZZ"
            En bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01XXXXXXXXXX" de bewoners met burgerservicenummer "99999XXXX", "99999YYYY", "99999ZZZZ"

        Scenario: persoon heeft in de gevraagde periode één verblijfplaats gehad
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4 < JJJ5M5D5
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
            Als de bewoning wordt gevraagd op burgerservicenummer met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ2-M2-D2
            Dan bevat het antwoord 1 bewoning
            En het antwoord bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN"
            En bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" de bewoners met burgerservicenummer "99999XXXX", "99999YYYY", "99999ZZZZ"


    Rule: voor elke bewoning van de persoon worden alleen bewoners geleverd die in de gevraagde periode ten minste één dag tegelijk met de gevraagde persoon op dat adres zijn/waren ingeschreven       

        Scenario: bewoner is op het adres ingeschreven nadat de gevraagde persoon daaruit verhuisd is (wordt niet geleverd)
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4 < JJJ5M5D5
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999NNNN" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01NNNNNNNNNN                         |
            Als de bewoning wordt gevraagd op burgerservicenummer met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ2-M2-D2&datumTotEnMet=JJJ5-M5-D5
            Dan bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" geen bewoner met burgerservicenummer "99999NNNN"

        Scenario: bewoner is verhuisd van het adres voordat de gevraagde persoon daar werd ingeschreven (wordt niet geleverd)
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4 < JJJ5M5D5
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999MMMM" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ1M1D1                         | GGGG010000YYYYYY                         |
                | 58        | JJJ0M0D0                         | GGGG01NNNNNNNNNN                         |
            Als de bewoning wordt gevraagd op burgerservicenummer met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ0-M0-D0&datumTotEnMet=JJJ5-M5-D5
            Dan bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" geen bewoner met burgerservicenummer "99999MMMM"

        Scenario: bewoner woonde wel gelijktijdig met de gevraagde persoon op het adres, maar in de gevraagde periode niet meer (wordt niet geleverd)
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4 < JJJ5M5D5
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            Als de bewoning wordt gevraagd op burgerservicenummer met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ3-M3-D3&datumTotEnMet=JJJ4-M4-D4
            Dan bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" geen bewoner met burgerservicenummer "99999YYYY"

        Scenario: bewoner woonde wel gelijktijdig met de gevraagde persoon op het adres, maar in de gevraagde periode nog niet (wordt niet geleverd)
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4 < JJJ5M5D5
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
            Als de bewoning wordt gevraagd op burgerservicenummer met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ0-M0-D0&datumTotEnMet=JJJ1-M1-D1
            Dan bevat de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" geen bewoner met burgerservicenummer "99999ZZZZ"


    Rule: wanneer er meer dan 100 medebewoners zijn op een adres, wordt alleen de gevraagde persoon als bewoner geleverd

        Scenario: in de gevraagde periode zijn er meer dan 100 bewoners (indicatieVeelBewoners: true, alleen de gevraagde persoon wordt geleverd)
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven er zijn op datum "2021-09-01" 101 personen ingeschreven met verblijfplaats adresseerbaarObjectIdentificatie (11.80) gelijk aan "GGGG01NNNNNNNNNN"
            En de persoon met burgerservicenummer "99999XXXX" was op datum "2021-09-01" ingeschreven met verblijfplaats adresseerbaarObjectIdentificatie (11.80) gelijk aan "GGGG01NNNNNNNNNN"
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=99999XXXX&peildatum=2021-09-01
            Dan bevat de bewoning property "indicatieVeelBewoners" met waarde true
            En heeft de bewoning 1 bewoner met burgerservicenummer "99999XXXX"
            En bevat de bewoning ten minste 1 adres


    Rule: wanneer een persoon meerdere (historische) verblijfplaatsen met dezelfde datumAanvangAdreshouding heeft, wordt alleen bewoning opgenomen voor de verblijfplaats met de meest recente datumIngangGeldigheid

        Scenario: adres van bewoner is gewijzigd door hernummering in de BAG
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ2M2D2                         | JJJ3M3D3                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
                | 58        | JJJ2M2D2                         | JJJ2M2D2                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN1                      |
                | 58        | JJJ1M1D1                         | JJJ1M1D1                      | GGGG01XXXXXXXXXX                         | GGGG20XXXXXXXXXX                      |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ0-M0-D0&datumTotEnMet=JJJ3-M3-D3
            Dan bevat het antwoord 2 bewoningen
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" 1 bewoner met burgerservicenummer "99999XXXX"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" een adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN2"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNNN" GEEN adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN1"
        
        Scenario: adres van bewoner is gewijzigd door splitsing van het verblijfsobject in de BAG
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ1M1D1                         | JJJ2M2D2                      | GGGG01NNNNNNNNN2                         | GGGG20NNNNNNNNN2                      |
                | 58        | JJJ1M1D1                         | JJJ1M1D1                      | GGGG01NNNNNNNNN1                         | GGGG20NNNNNNNNN1                      |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ3-M3-D3
            Dan bevat het antwoord 1 bewoning
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2" 1 bewoner met burgerservicenummer "99999XXXX"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2" een adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN2"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2" GEEN adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN1"

        Scenario: er is een adresseerbaarObjectIdentificatie en nummeraanduidingIdentificatie toegekend aan de verblijfplaats van de persoon
            Gegeven de persoon met burgerservicenummer "999993847" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | 20010215                         | 20091101                      | 0518010000781379                         | 0518200000781378                      |
                | 8         | 20010215                         | 20010215                      |                                          |                                       |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999993847&datumVan=2001-01-01&datumTotEnMet=2009-12-31
            Dan bevat het antwoord 1 bewoning
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "0518010000781379"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "0518010000781379" 1 bewoner met burgerservicenummer "999993847"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "0518010000781379" een adres met nummeraanduidingIdentificatie "0518200000781378"


    Rule: alleen verblijfplaatsen met een adresseerbaar object identificatie worden geleverd

        Scenario: persoon met niet-BAG adres, verblijfplaats met locatieomschrijving en verblijf in het buitenland
            Gegeven de persoon met burgerservicenummer "999994669" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datum aanvang adres buitenland (13.20) | adresseerbaarObjectIdentificatie (11.80) | straat (11.10)         | locatieomschrijving (12.10) | land (13.10) |
                | 8         | 19940508                         |                                        | 0599010000287986                         | Johan in 't Veltstraat |                             |              |
                | 58        | 19940508                         |                                        |                                          | Johan in 't Veltstraat |                             |              |
                | 58        | 19930910                         |                                        |                                          |                        | Woonboot "'t Lelijk Eentje" |              |
                | 58        |                                  | 19930215                               |                                          |                        |                             | 8027         |
                | 58        | 19611230                         |                                        |                                          | Curaçaolaan            |                             |              |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999994669&datumVan=1960-01-01&datumTotEnMet=1999-12-31
            Dan bevat het antwoord 1 bewoning
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2"

        Scenario: persoon is vertrokken onbekend waarheen
            Gegeven de persoon met burgerservicenummer "999993586" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datum aanvang adres buitenland (13.20) | adresseerbaarObjectIdentificatie (11.80) | land (13.10) |
                | 8         |                                  | 20080402                               |                                          | 0000         |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999993586&datumVan=2008-04-02&datumTotEnMet=2020-12-31
            Dan heeft het antwoord http statuscode 200
            En bevat het antwoord GEEN bewoningen


    Rule: verblijfplaatsen met indicatie onjuist (84.10) worden genegeerd

        Scenario: verblijfplaats van persoon is onjuist
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | onjuist (84.10) |
                | 8         | JJJ3M3D3                         | GGGG01NNNNNNNNN2                         | GGGG20NNNNNNNNN2                      |                 |
                | 58        | JJJ2M2D2                         | GGGG01XXXXXXXXXX                         |                                       | O               |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNN1                         | GGGG20NNNNNNNNN1                      |                 |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=99999XXXX&datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ4-M4-D4
            Dan bevat het antwoord 2 bewoningen
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN1"
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2"
            En bevat het antwoord GEEN bewoning met adresseerbaarObjectIdentificatie "GGGG01XXXXXXXXXX"
            En heeft de bewoning met adresseerbaarObjectIdentificatie "GGGG01NNNNNNNNN2" 1 bewoner met burgerservicenummer "99999XXXX" en datumTot met datum "JJJ3-M3-D3"

    
    Rule: bewoningen worden in het antwoord aflopend gesorteerd op datum aanvang adreshouding van de betreffende persoon, zodat de meest actuele bovenaan staat

        Scenario: persoon is verhuisd naar een ander adres
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999992466
            Dan bevat het antwoord in _embedded.bewoningen 2 items
            En heeft bewoning 1 adresseerbaarObjectIdentificatie "0518010000412416"
            En heeft bewoning 2 adresseerbaarObjectIdentificatie "0518010000362848"