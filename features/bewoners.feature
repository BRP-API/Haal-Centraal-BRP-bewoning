# language: nl
Functionaliteit: Als gebruiker wil ik weten welke personen in een periode op een adres waren ingeschreven

    Rule: bij een bewoner waar de betreffende verblijfplaats historisch is wordt een datumTot opgenomen, die gelijk is aan de datum aanvang adreshouding dan wel Datum aanvang adres buitenland van de daarop volgende verblijfplaats van die persoon

        Scenario: persoon is verhuisd naar een ander adres in de gevraagde periode
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000362848?datumVan=2016-01-01&datumTotEnMet=2016-12-31
            Dan heeft de bewoner met burgerservicenummer "999992466" een property datumTot met datum "2016-08-16"

        Scenario: persoon is verhuisd naar een ander adres na de gevraagde periode
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000362848?datumVan=2015-01-01&datumTotEnMet=2015-12-31
            Dan heeft de bewoner met burgerservicenummer "999992466" een property datumTot met datum "2016-08-16"

        Scenario: persoon is geëmigreerd
            Gegeven de persoon met burgerservicenummer "999993483" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | datum aanvang adres buitenland (13.20) |
                | 8         | -                                | -                                        | 20140702                               |
                | 58        | 20120305                         | 1811011200020001                         | -                                      |
            Als bewoning wordt gevraagd met /bewoningen/1811011200020001?datumVan=2010-01-01&datumTotEnMet=2014-12-31
            Dan heeft de bewoner met burgerservicenummer "999993483" een property datumTot met datum "2014-07-02"

        Scenario: persoon is vertrokken onbekend waarheen
            Gegeven de persoon met burgerservicenummer "999994529" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | datum aanvang adres buitenland (13.20) | land (13.10) |
                | 8         | -                                | -                                        | 20190405                               | 0000         |
                | 58        | 20050101                         | 1955010000040150                         | -                                      | -            |
            Als bewoning wordt gevraagd met /bewoningen/1955010000040150?datumVan=2019-01-01&datumTotEnMet=2019-12-31
            Dan heeft de bewoner met burgerservicenummer "999994529" een property datumTot met datum "2019-04-05"

        Scenario: persoon is verhuisd op onbekende datum
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 00000000                         |                                          |
                | 58        | JJJJMMDD                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=1990-01-01&datumTotEnMet=2021-09-30
            Dan heeft de bewoner met burgerservicenummer "99999XXXX" GEEN property datumTot

            # voor een gebruiker lijkt het dus alsof de persoon hier nu nog steeds woont, terwijl het zeker is dat deze hier niet meer woont.

        Scenario: persoon is geëimigreerd op onbekende datum
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | datum aanvang adres buitenland (13.20) |
                | 8         |                                  |                                          | 00000000                               |
                | 58        | JJJJMMDD                         | GGGG01XXXXXXXXXX                         |                                        |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=1990-01-01&datumTotEnMet=2021-09-30
            Dan heeft de bewoner met burgerservicenummer "99999XXXX" GEEN property datumTot

            # voor een gebruiker lijkt het dus alsof de persoon hier nu nog steeds woont, terwijl het zeker is dat deze hier niet meer woont.

        Scenario: persoon is verhuisd op gedeeltelijk onbekende datum
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJJ0000                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJJMMDD                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=1990-01-01&datumTotEnMet=2021-09-30
            Dan heeft de bewoner met burgerservicenummer "99999XXXX" een property datumTot met jaar=JJJJ
        
        Scenario: persoon is actueel ingeschreven op het gevraagde adres (datumTot wordt niet geleverd)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000412416
            Dan heeft de bewoner met burgerservicenummer "999992466" GEEN property datumTot


    Rule: verblijfplaatsen met indicatie onjuist (84.10) worden genegeerd bij het bepalen van de datumTot

        Scenario: verblijfplaats van persoon is onjuist
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ0M0D0 < JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3 < JJJ4M4D4
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) | onjuist (84.10) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXX2                         | GGGG20XXXXXXXXX2                      |                 |
                | 58        | JJJ2M2D2                         | GGGG01XXXXXXXXX1                         | GGGG20XXXXXXXXX1                      | O               |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNNN                      |                 |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ3-M3-D3
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumTot met datum "JJJ3-M3-D3"

    
    Rule: bewoners worden geleverd die in de gevraagde periode ten minste 1 dag waren ingeschreven op het adres

        Scenario: persoon was ingeschreven op het adres tot de gevraagde datumVan (geen bewoner in gevraagde peride)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000362848?datumVan=2016-08-16&datumTotEnMet=2016-12-31
            Dan bevat het antwoord GEEN bewoner met burgerservicenummer "999992466"

        Scenario: uitverhuizen tijdens gevraagde periode: persoon was ingeschreven op het adres tot één dag na datumVan (bewoner in de gevraagde periode)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000362848?datumVan=2016-08-15&datumTotEnMet=2016-12-31
            Dan bevat het antwoord de bewoner met burgerservicenummer "999992466" en property datumAanvangAdreshouding met datum "1990-06-01"
            
        Scenario: persoon was ingeschreven op het adres vanaf de datumTotEnMet (bewoner in de gevraagde periode)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000412416?datumVan=2016-01-01&datumTotEnMet=2016-08-16
            Dan bevat het antwoord de bewoner met burgerservicenummer "999992466" en property datumAanvangAdreshouding met datum "2016-08-16"

        Scenario: in gevraagde periode wordt kind wordt geboren en ingeschreven op adres (kind is bewoner in de gevraagde periode)
            Gegeven de persoon met burgerservicenummer "999994931" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 19911220                         | 0518010000617227                         |
            En de persoon met burgerservicenummer "999994785" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 19911220                         | 0518010000617227                         |
            En de persoon met burgerservicenummer "999993306" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 19920101                         | 0518010000617227                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000617227?datumVan=1991-12-31&datumTotEnMet=1992-12-01
            Dan bevat het antwoord 3 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "999994931" en property datumAanvangAdreshouding met datum "1991-12-20"
            En bevat het antwoord de bewoner met burgerservicenummer "999994785" en property datumAanvangAdreshouding met datum "1991-12-20"
            En bevat het antwoord de bewoner met burgerservicenummer "999993306" en property datumAanvangAdreshouding met datum "1992-01-01"

        Scenario: persoon was ingeschreven voor heel de gevraagde periode
            Gegeven de persoon met burgerservicenummer "999990159" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000821308                         |
                | 58        | 20000228                         | 0518010000759226                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000759226?datumVan=2010-01-01&datumTotEnMet=2010-12-31
            Dan bevat het antwoord de bewoner met burgerservicenummer "999990159" en property datumAanvangAdreshouding met datum "2000-02-28"

        Scenario: persoon was ingeschreven voor een deel van de gevraagde periode
            Gegeven de persoon met burgerservicenummer "999990159" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000821308                         |
                | 58        | 20000228                         | 0518010000759226                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000759226?datumVan=2016-01-01&datumTotEnMet=2019-12-31
            Dan bevat het antwoord de bewoner met burgerservicenummer "999990159" en property datumAanvangAdreshouding met datum "2000-02-28"

        Scenario: persoon was binnen de gevraagde periode tijdelijk op een ander adres ingeschreven
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ2M2D2                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=JJJ1-01-01&datumTotEnMet=JJJ3-12-31
            Dan bevat het antwoord 2 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ3-M1-D1"

        Scenario: opeenvolgende bewoners
        # To Do: persoon voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01NNNNNNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=JJJ1-02-02&datumTotEnMet=JJJ3-12-31
            Dan bevat het antwoord 2 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ3-M3-D3"


        Scenario: datumAanvangAdreshouding is gelijk aan de peildatum (bewoner op de gevraagde peildatum)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000412416?peildatum=2016-08-15
            Dan bevat het antwoord de bewoner met burgerservicenummer "999992466" en property datumAanvangAdreshouding met datum "2016-08-16"

        Scenario: datumTot is gelijk aan de peildatum (geen bewoner op de gevraagde peildatum)
            Gegeven de persoon met burgerservicenummer "999992466" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20160816                         | 0518010000412416                         |
                | 58        | 19900601                         | 0518010000362848                         |
            Als bewoning wordt gevraagd met /bewoningen/0518010000362848?peildatum=2016-08-15
            Dan bevat het antwoord GEEN bewoner met burgerservicenummer "999992466"


    Rule: bij een (gedeeltelijk) onbekende datumAanvangAdreshouding, wordt aangenomen dat de persoon op de eerste dag van de onzekerheidstijd op het adres was ingeschreven

        Scenario: alleen maand en jaar van de datumAanvangAdreshouding zijn bekend en gelijk aan jaar en maand in de gevraagde datumTotEnMet
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M200                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1990-01-01&datumTotEnMet=JJJ2-M2-01
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met jaar=JJJ2 en maand=M2

        Scenario: alleen jaar van de datumAanvangAdreshouding is bekend en gelijk aan jaar in de gevraagde datumTotEnMet
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ20000                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1990-01-01&datumTotEnMet=JJJ2-01-01
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met jaar=JJJ2M2D2

        Scenario: de datumAanvangAdreshouding is geheel onbekend en er is een eerdere verblijfplaats
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 00000000                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJJMMDD                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?peildatum=JJJJ-MM-DD
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en GEEN property datumAanvangAdreshouding

        # Moet er rule zijn voor aannemen onbekende datum aanvang > datum aanvang vorige verblijfplaats? (persoon kan niet eerder op adres hebben gewoond want woonde toen zeker ergens anders)

        Scenario: de datumAanvangAdreshouding is geheel onbekend van de eerste verblijfplaats en de bewoning wordt gevraagd vóór de geboorte
            Gegeven de persoon met burgerservicenummer "999991449" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 00000000                         | 0599010370005001                         |
            En de persoon met burgerservicenummer "999991449" heeft geboortedatum (01.03.10) "19640209"
            Als bewoning wordt gevraagd met /bewoningen/0599010370005001?peildatum=1950-01-01
            Dan bevat het antwoord de bewoner met burgerservicenummer "999991449" en GEEN property datumAanvangAdreshouding

        # Moet er rule zijn voor aannemen datum aanvang = geboortedatum? (persoon kan niet eerder op adres hebben gewoond want was toen nog niet geboren)


    Rule: bij een (gedeeltelijk) onbekende datumTot, wordt aangenomen dat de persoon op de laatste dag van de onzekerheidstijd op het adres was ingeschreven

        Scenario: alleen maand en jaar van de datumTot zijn bekend en gelijk aan jaar en maand in de gevraagde datumVan
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M200                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=JJJ2-M2-30&datumTotEnMet=2021-09-30
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"

        Scenario: alleen maand en jaar van de datumTot zijn bekend en liggen vóór de gevraagde datumVan
        # To Do: persoon voor deze situatie vinden of laten maken
        # hieronder is M3=M2+1, bijvoorbeeld als JJJ2M200="20190500", dan is datumVan=2019-06-01
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M200                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=JJJ2-M3-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord GEEN bewoner met burgerservicenummer "99999XXXX"

        Scenario: alleen maand en jaar van de datumTot zijn bekend en gelijk aan jaar en maand in de gevraagde peildatum
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M200                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?peildatum=JJJ2-M2-30
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"

        Scenario: alleen jaar van de datumTot is bekend en gelijk aan jaar in de gevraagde datumVan
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ20000                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=JJJ2-12-31&datumTotEnMet=2021-09-30
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"

        Scenario: alleen jaar van de datumTot is bekend en eerder dan het jaar in de gevraagde datumVan
        # To Do: persoon voor deze situatie vinden of laten maken
        # hieronder is JJJ3=JJJ2+1, bijvoorbeeld als JJJ20000="20190000", dan is datumVan=2020-01-01
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ20000                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=JJJ3-01-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord GEEN bewoner met burgerservicenummer "99999XXXX"

        Scenario: alleen jaar van de datumTot is bekend en gelijk aan jaar in de gevraagde peildatum
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ20000                         | GGGG01NNNNNNNNNN                         |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?peildatum=JJJ2-12-31
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"

        Scenario: persoon is verhuisd op onbekende datum en daarna weer met bekende datum
        # To Do: persoon voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
                | 58        | 00000000                         |                                          |
                | 58        | JJJ1M1D1                         | GGGG01XXXXXXXXXX                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01XXXXXXXXXX?datumVan=JJJ2-M2-D2&datumTotEnMet=2021-09-30
            Dan bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en GEEN property datumTot

            # Moet er rule zijn voor aannemen datumTot = datum aanvang latere verblijfplaats (na verblijfplaats met onbekende datum aanvang)?

    
    Rule: wanneer er meer dan 100 bewoners zijn op het adres in gevraagde periode, worden geen bewoners geleverd, maar wel indicatieVeelBewoners

        Scenario: studentenhuis/verzorgingshuis met veel doorstroming: in de gevraagde periode zijn er meer dan 100 bewoners (indicatieVeelBewoners: true)
        # To Do: personen voor deze situatie vinden of laten maken
        # de testsituatie is dat er nooit >100 personen tegelijk staan ingeschreven, maar opgeteld in de hele periode wel
            Gegeven er zijn in de periode van "2000-01-01" tot en met "2021-09-30", meer dan 100 personen ingeschreven geweest met verblijfplaats adresseerbaarObjectIdentificatie (11.80) gelijk aan "GGGG01NNNNNNNNNN"
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=2000-01-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord GEEN bewoners
            En bevat het antwoord property "indicatieVeelBewoners" met waarde true
            En bevat het antwoord ten minste 1 adres

        # is het maximaal aantal van 100 terug te geven bewoners vastgesteld of kan dit nog een ander aantal worden?

        Scenario: gemeentelijk briefadres daklozen: op de gevraagde peildatum zijn er meer dan 100 bewoners (indicatieVeelBewoners: true)
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven er zijn op datum "2021-09-01" 101 personen ingeschreven met verblijfplaats adresseerbaarObjectIdentificatie (11.80) gelijk aan "GGGG01NNNNNNNNNN"
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?peildatum=2021-09-01
            Dan bevat het antwoord GEEN bewoners
            En bevat het antwoord property "indicatieVeelBewoners" met waarde true
            En bevat het antwoord ten minste 1 adres

        # is het maximaal aantal van 100 terug te geven bewoners vastgesteld of kan dit nog een ander aantal worden?

        Scenario: in de gevraagde periode zijn er minder dan 100 bewoners, maar totale bewoners ooit is meer dan 100 (bewoners worden geleverd)
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven er zijn op datum "2021-10-01" 99 personen ingeschreven met verblijfplaats adresseerbaarObjectIdentificatie (11.80) gelijk aan "GGGG01NNNNNNNNNN"
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?peildatum=2021-10-01
            Dan bevat het antwoord 99 personen
            En bevat het antwoord GEEN property "indicatieVeelBewoners"
    

    Rule: bewoners worden in het antwoord aflopend gesorteerd op datum aanvang adreshouding, en daarbinnen aflopend gesorteerd op datumTot, zodat de meest actuele bovenaan staat
        # of andersom eerst op datumTot en daarna op datumAanvangAdreshouding?

        Scenario: bewoner met meest recente datumAanvangAdreshouding komt bovenaan
            Gegeven de persoon met burgerservicenummer "999995108" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | 
                | 8         | 19951010                         | 0599010055007301                         |
            En de persoon met burgerservicenummer "999992119" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 20100225                         | 0599010055007301                         |
            En de persoon met burgerservicenummer "999991036" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | 19980401                         | 0599010055007301                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=2020-01-01&datumTotEnMet=2020-06-30
            Dan bevat het antwoord 3 bewoners
            En heeft bewoners[0] property "burgerservicenummer" met waarde "999992119" en "datumAanvangAdreshouding" met datum "2010-02-25"
            En heeft bewoners[1] property "burgerservicenummer" met waarde "999991036" en "datumAanvangAdreshouding" met datum "1998-04-01"
            En heeft bewoners[2] property "burgerservicenummer" met waarde "999995108" en "datumAanvangAdreshouding" met datum "1995-10-10"

        Scenario: bij zelfde datumAanvangAdreshouding komen bewoners met meest recente datumTot bovenaan
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3
            Gegeven de persoon met burgerservicenummer "99999NNN1" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999NNN2" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999NNN3" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ2M2D2                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ3-M3-D3
            Dan bevat het antwoord 3 bewoners
            En heeft bewoners[0] property "burgerservicenummer" met waarde "99999NNN2" en property "datumAanvangAdreshouding" met datum "JJJ2-M2-D2"
            En heeft bewoners[1] property "burgerservicenummer" met waarde "99999NNN1" en property "datumAanvangAdreshouding" met datum "JJJ1-M1-D1"
            En heeft bewoners[2] property "burgerservicenummer" met waarde "99999NNN3" en property "datumAanvangAdreshouding" met datum "JJJ1-M1-D1"

        Scenario: bij bewoners met zelfde datumAanvangAdreshouding komt actuele bewoner boven de historische bewoner
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ1M1D1 < JJJ2M2D2 < JJJ3M3D3
            Gegeven de persoon met burgerservicenummer "99999NNN1" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999NNN2" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ3M3D3                         | GGGG01XXXXXXXXXX                         |
                | 58        | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         |
            En de persoon met burgerservicenummer "99999NNN3" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) |
                | 8         | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=JJJ1-M1-D1&datumTotEnMet=JJJ3-M3-D3
            Dan bevat het antwoord 3 bewoners
            En heeft bewoners[0] property "burgerservicenummer" met waarde "99999NNN2" en property "datumAanvangAdreshouding" met datum "JJJ2-M2-D2"
            En heeft bewoners[1] property "burgerservicenummer" met waarde "99999NNN3" en property "datumAanvangAdreshouding" met datum "JJJ1-M1-D1"
            En heeft bewoners[1] property "burgerservicenummer" met waarde "99999NNN1" en property "datumAanvangAdreshouding" met datum "JJJ1-M1-D1"
