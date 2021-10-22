# language: nl
Functionaliteit: Als gebruiker wil ik bewoning kunnen zoeken in een periode of op een peildatum

    Rule: raadplegen van bewoning van een adres dat niet bekend is in de BRP registratie geeft een 404 fout
    # deze rule en onderstaande voorbeelden tonen huidige implementatie in Den Haag
    # is dat gewenst vanuit gebruikerperspectief?
    # voorstel van Melvin: uitgaan dat adresseerbaar object altijd bestaat en dus bij opgeven ado id altijd 1 bewoning teruggeven

        Scenario: raadplegen bewoning van bedrijfspand waar nooit een persoon op ingeschreven heeft gestaan (geeft een 404 fout)
            Als bewoning wordt gevraagd met /bewoningen/0518010000854789&peildatum=2021-01-01
            Dan heeft het antwoord http statuscode 404

            # Dan heeft het antwoord http statuscode 200
            # En bevat het antwoord geen bewoners
            # En bevat het antwoord geen adressen

        Scenario: zoeken bewoning op adresseerbaarObjectIdentificatie voor bedrijfspand waar nooit een persoon op ingeschreven heeft gestaan (geeft lege collectie)
            Als bewoning wordt gevraagd met /bewoningen?adresseerbaarObjectIdentificatie=0518010000854789&peildatum=2021-01-01
            Dan heeft het antwoord http statuscode 200
            En bevat het antwoord GEEN bewoningen

            # Dan heeft het antwoord http statuscode 200
            # En bevat het antwoord 1 bewoning
            # En bevat de bewoning geen bewoners
            # En bevat de bewoning geen adressen

        Scenario: zoeken bewoning met een onjuist burgerservicenummer (geeft lege collectie)
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=123456789&peildatum=2021-01-01
            Dan heeft het antwoord http statuscode 200
            En bevat het antwoord GEEN bewoningen

        Scenario: gevraagde periode ligt vóór de eerste bewoning van het adres (geeft adres, geen bewoners)
            Gegeven de persoon met burgerservicenummer "999995108" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | 19951010                         | 0599010000228162                         | 0599200001012572                      |
            En er is geen andere persoon die eerder op dit adres woonden
            Als bewoning wordt gevraagd met /bewoningen/0599010000228162?datumVan=1990-01-01&datumTotEnMet=1990-12-31
            Dan heeft het antwoord http status code 200
            En bevat het antwoord GEEN bewoners
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "0599200001012572"

            # of moeten alleen adressen worden opgenomen van geleverde bewoners?

        Scenario: gevraagde periode ligt ná de laatste bewoning van het adres (geeft adres, geen bewoners)
            Gegeven de persoon met burgerservicenummer "999994815" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | datum aanvang adres buitenland (13.20) |
                | 8         |                                  |                                          |                                       | 20140702                               |
                | 58        | 20120305                         | 1811011200020001                         | 1811201200020001                      |                                        |
            En alle andere voormalige bewoners van deze woning waren uiterlijk 2-7-2014 uitgeschreven
            En de woning met adresseerbaarObjectIdentificatie "1811011200020001" is sinds 2-7-2014 niet meer bewoond 
            Als bewoning wordt gevraagd met /bewoningen/1811011200020001?datumVan=2020-01-01&datumTotEnMet=2020-12-31
            Dan heeft het antwoord http status code 200
            En bevat het antwoord GEEN bewoners
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "1811201200020001"

            # of moeten alleen adressen worden opgenomen van geleverde bewoners?


    Rule: vragen om bewoning in de toekomst geeft geen bewoners
    # of moet vragen om bewoning in de toekomst een foutmelding geven (want we weten niks over de toekomst)
    # zo ja mag je dan ook geen datumTotEnMet in de toekomst opgeven?

        Scenario: vragen om bewoning met datumVan in de toekomst
            Gegeven de persoon met burgerservicenummer "999993847" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | datum aanvang adres buitenland (13.20) |
                | 8         | 20010215                         | 0518010000781379                         | 0518200000781378                      |                                        |
            Als bewoning wordt gevraagd met /bewoningen/0518010000781379?datumVan=2030-01-01&datumTotEnMet=2030-12-31
            Dan heeft het antwoord http status code 200
            En bevat het antwoord GEEN bewoners
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "0518200000781378"

        Scenario: zoeken van bewoning op burgerservicenummer met datumVan in de toekomst
            Gegeven de persoon met burgerservicenummer "999993847" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | datum aanvang adres buitenland (13.20) |
                | 8         | 20010215                         | 0518010000781379                         | 0518200000781378                      |                                        |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999993847&datumVan=2030-01-01&datumTotEnMet=2030-12-31
            Dan heeft het antwoord http status code 200
            En bevat het antwoord GEEN bewoningen

        Scenario: vragen om bewoning met peildatum in de toekomst
            Gegeven de persoon met burgerservicenummer "999993847" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | datum aanvang adres buitenland (13.20) |
                | 8         | 20010215                         | 0518010000781379                         | 0518200000781378                      |                                        |
            Als bewoning wordt gevraagd met /bewoningen/0518010000781379?peildatum=2030-01-01
            Dan heeft het antwoord http status code 200
            En bevat het antwoord GEEN bewoners
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "0518200000781378"

        Scenario: vragen om bewoning met datumTotEnMet in de toekomst
            Gegeven de persoon met burgerservicenummer "999993847" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | datum aanvang adres buitenland (13.20) |
                | 8         | 20010215                         | 0518010000781379                         | 0518200000781378                      |                                        |
            Als bewoning wordt gevraagd met /bewoningen/0518010000781379?datumVan=2020-01-01&datumTotEnMet=2030-12-31
            Dan heeft het antwoord http status code 200
            En bevat het antwoord de bewoner met burgerservicenummer "999993847" en property datumAanvangAdreshouding met datum "2001-02-15"

    
    Rule: vragen om bewoning met datumTotEnMet maar zonder datumVan geeft bewoning van de allereerste bewoning tot en met datumTotEnMet
        
        Scenario: vragen om bewoning met datumTotEnMet maar zonder datumVan
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG010000XXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG010000NNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG010000NNNNNN&datumTotEnMet=JJJ3-M3-D3
            Dan bevat het antwoord 2 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"


    Rule: vragen om bewoning met datumVan maar zonder datumTotEnMet geeft bewoning van datumVan tot en met vandaag
        
        Scenario: vragen om bewoning met datumVan maar zonder datumTotEnMet
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG010000XXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG010000NNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG010000NNNNNN&datumVan=JJJ3-M3-D3
            Dan bevat het antwoord 2 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"
            En bevat het antwoord de bewoner met burgerservicenummer "99999ZZZZ" en property datumAanvangAdreshouding met datum "JJJ1-M4-D4"


    Rule: vragen om bewoning zonder periode én zonder peildatum geeft alle bewoning van de allereerste bewoning tot en met vandaag
    # specificatie staat nu toe om bewoning te vragen zonder periode of peildatum. Moet dat niet worden aangescherpt?

        Scenario: vragen om bewoning zonder periode of peildatum
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG010000XXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG010000NNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG010000NNNNNN
            Dan bevat het antwoord 3 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"
            En bevat het antwoord de bewoner met burgerservicenummer "99999ZZZZ" en property datumAanvangAdreshouding met datum "JJJ1-M4-D4"


            # Dan heeft het antwoord http status code 400

        Scenario: zoeken van bewoning op burgerservicenummer zonder periode of peildatum
        # specificatie staat nu toe om bewoning te vragen zonder periode of peildatum. Moet dat niet worden aangescherpt?
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999992466
            Dan bevat het antwoord 2 bewoningen
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "0518010000412416"
            En bevat het antwoord bewoning met adresseerbaarObjectIdentificatie "0518010000362848"

            # Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999993653
            # Dan heeft het antwoord http status code 400


    Rule: vragen om bewoning geeft een foutmelding als de periode en/of peildatum parameterwaarden elkaar uitsluiten

        Scenario: peildatum ligt buiten periode (geeft foutmelding)
            Gegeven de persoon met burgerservicenummer "999995108" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | 19951010                         | 0599010000228162                         | 0599200001012572                      |
            Als bewoning wordt gevraagd met /bewoningen/0599010000228162?datumVan=2020-01-01&datumTotEnMet=2020-12-31&peildatum=2021-07-01
            Dan heeft het antwoord http status code 400
            En bevat het antwoord property "title" met waarde "Een of meerdere parameters zijn niet correct."
            En bevat het antwoord property "detail" met waarde "De foutieve parameter(s) zijn: datumTotEnMet."
            En bevat het antwoord property "invalidParams" met 1 items
            En bevat het antwoord de invalidParams met name "datumTotEnMet" en code "dateRange" en reason "Waarde mag niet eerder zijn dan waarde van peildatum."

            # ik ben niet echt gelukkig met deze foutmelding. Keuze om datumTotEnMet fout te noemen is erg triviaal en raakt niet de kern van de fout.
            # er is dus in provider geïmplementeerd validatie voor datumTotEnMet ≥ peildatum en datumVan ≤ peildatum
            # moet gebruik van peildatum en periode elkaar niet gewoon uitsluiten, zelfs wanneer periode en peildatum elkaar overlappen?

        Scenario: datumVan ligt na datumTotEnMet (geeft foutmelding)
            Gegeven de persoon met burgerservicenummer "999995108" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | 19951010                         | 0599010000228162                         | 0599200001012572                      |
            Als bewoning wordt gevraagd met /bewoningen/0599010000228162?datumVan=2021-01-01&datumTotEnMet=2020-12-31
            Dan heeft het antwoord http status code 400
            En bevat het antwoord property "title" met waarde "Een of meerdere parameters zijn niet correct."
            En bevat het antwoord property "detail" met waarde "De foutieve parameter(s) zijn: datumVan."
            En bevat het antwoord property "invalidParams" met 1 items
            En bevat het antwoord de invalidParams met name "datumVan" en code "dateRange" en reason "Waarde mag niet later zijn dan waarde van datumTotEnMet."

        Scenario: peildatum ligt binnen periode (geeft bewoning op peildatum)
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG010000XXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG010000NNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/0599010000228162?datumVan=JJJ1-01-01&datumTotEnMet=JJJ4-12-31&peildatum=JJJ3-M3-D3
            Dan bevat het antwoord 1 bewoner
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"

        Scenario: peildatum is gelijk aan periode: datumVan==datumTotEnMet==peildatum (geeft bewoning op peildatum)
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG010000XXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG010000NNNNNN                         |
            En de persoon met burgerservicenummer "99999ZZZZ" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ4M4D4                         | GGGG010000NNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/0599010000228162?datumVan=JJJ3-M3-D3&datumTotEnMet=JJJ3-M3-D3&peildatum=JJJ3-M3-D3
            Dan bevat het antwoord 1 bewoner
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"


    Rule: bij het zoeken van bewoningen moet óf parameter adresseerbaarObjectIdentificatie óf parameter burgerservicenummer worden opgenomen (niet beide)

        Scenario: vragen om bewoningen zonder adresseerbaarObjectIdentificatie of burgerservicenummer (geeft een fout)
            Als bewoning wordt gevraagd met /bewoningen?peildatum=2021-01-01
            Dan heeft het antwoord http status code 400
            En bevat het antwoord property "title" met waarde "Geef tenminste één parameter op."
            En bevat het antwoord property "detail" met waarde "Geef waarde aan minimaal één van de volgende velden: burgerservicenummer of adresseerbaarObjectIdentificatie"
            En het antwoord bevat property "code" met waarde "paramsRequired"


        Scenario: vragen om bewoningen met zowel adresseerbaarObjectIdentificatie als burgerservicenummer (geeft een fout)
            Als bewoning wordt gevraagd met /bewoningen?adresseerbaarObjectIdentificatie=0518010000412416&burgerservicenummer=999993653&peildatum=2021-01-01
            Dan heeft het antwoord http status code 400
            En het antwoord bevat property "title" met waarde "De combinatie van opgegeven parameters is niet toegestaan."
            En het antwoord bevat property "detail" met waarde "Geef waarde aan maximaal één van de volgende velden: burgerservicenummer of adresseerbaarObjectIdentificatie. Gebruik van beide is niet toegestaan."
            En het antwoord bevat property "code" met waarde "unsupportedCombi"
            En het antwoord bevat GEEN property "invalidParams"

        Scenario: vragen om bewoningen met adresseerbaarObjectIdentificatie en zonder burgerservicenummer (geeft bewoning)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen?adresseerbaarObjectIdentificatie=0518010000412416&peildatum=2021-01-01
            Dan heeft het antwoord http status code 200
            En bevat het antwoord 1 bewoning

        Scenario: vragen om bewoningen met burgerservicenummer en zonder adresseerbaarObjectIdentificatie (geeft bewoning)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen?burgerservicenummer=999992466&peildatum=2021-01-01
            Dan heeft het antwoord http status code 200
            En bevat het antwoord 1 bewoning