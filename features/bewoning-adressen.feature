# language: nl
Functionaliteit: Als gebruiker wil ik weten welke adressen de bewoning betreft
    Eén woning kan meerdere verschillende adressen hebben, bijvoorbeeld een huis met twee voordeuren.
    Daardoor kunnen verschillende bewoners op verschillende adressen staan ingeschreven, maar toch in dezelfde woning verblijven. 
    Voor bewoning willen we in zo'n geval toch alle bewoners van deze woning krijgen, ondanks dat de bewoners een ander adres hebben opgegeven.
    In zo'n geval hebben de verschillende adressen wel dezelfde adresseerbaarObjectIdentificatie. 
    Bewoning wordt geleverd op basis van de adresseerbaarObjectIdentificatie met alle bewoners op de verschillende adressen van deze woning.
    In de bewoning worden de verschillende adressen van de verschillende bewoners opgenomen.

    
    Rule: bewoners met verschillende adressen voor dezelfde woning worden samen geleverd

        Scenario: bewoner op hoofdadres en bewoner op nevenadres
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN1                      |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ2M2D2                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1900-01-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord 2 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ2-M2-D2"

        Scenario: adres van bewoner is gewijzigd door hernummering
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ1M1D1                         | JJJ3M3D3                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
                | 58        | JJJ1M1D1                         | JJJ2M2D2                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN1                      |
                | 58        | JJJ1M1D1                         | JJJ1M1D1                      | GGGG01NNNNNNNNNN                         | -                                     |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ4M4D4                         | JJJ4M4D4                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1900-01-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord 2 bewoners
            En bevat het antwoord de bewoner met burgerservicenummer "99999XXXX" en property datumAanvangAdreshouding met datum "JJJ1-M1-D1"
            En bevat het antwoord de bewoner met burgerservicenummer "99999YYYY" en property datumAanvangAdreshouding met datum "JJJ2-M2-D2"


    Rule: wanneer de bewoners van dezelfde woning op verschillende adressen zijn ingeschreven, worden deze verschillende adressen geleverd
    # moet de rule dus zijn dat alleen adressen van de getoonde bewoners worden getoond, of ook andere adressen van bewoners buiten de gevraagde periode?
    # bijvoorbeeld als periode voor eerste bewoning ligt, dus 0 bewoners worden geleverd, dan toch adres(sen) opnemen? (zie bewoning-parameters.feature scenario "gevraagde periode ligt vóór de eerste bewoning van het adres")

        Scenario: bewoner op hoofdadres en bewoner op nevenadres
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ1M2D2                         | GGGG01XXXXXXXXXX                         | GGGG20XXXXXXXXXX                      |
                | 8         | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN1                      |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ3M3D3                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1900-01-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord 2 adressen
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN1"
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN2"

        Scenario: bewoner op hoofdadres in gevraagde periode en bewoner op nevenadres buiten gevraagde periode
        # To Do: personen voor deze situatie vinden of laten maken
        # JJJ3M3D3 ligt na (recenter) JJJ1M2D2
        # datumTotEnMet=JJJ4-M4-D4 ligt na JJJ1M1D1, voor JJJ1M2D2 en voor JJJ3M3D3 (bijv. JJJ1M1D1=20150301, JJJ1M2D2=20180715, JJJ3M3D3=20180801)
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ1M2D2                         | GGGG01XXXXXXXXXX                         | GGGG20XXXXXXXXXX                      |
                | 58        | JJJ1M1D1                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN1                      |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ3M3D3                         | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1900-01-01&datumTotEnMet=JJJ2-M2-D2
            Dan bevat het antwoord 1 adres
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN1"

        Scenario: adres van bewoners is gewijzigd door hernummering
        # To Do: personen voor deze situatie vinden of laten maken
            Gegeven de persoon met burgerservicenummer "99999XXXX" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ1M1D1                         | JJJ3M3D3                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
                | 58        | JJJ1M1D1                         | JJJ2M2D2                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN1                      |
                | 58        | JJJ1M1D1                         | JJJ1M1D1                      | -                                        | -                                     |
            En de persoon met burgerservicenummer "99999YYYY" heeft de volgende categorievoorkomens:
                | categorie | datumAanvangAdreshouding (10.30) | datumIngangGeldigheid (85.10) | adresseerbaarObjectIdentificatie (11.80) | nummeraanduidingIdentificatie (11.90) |
                | 8         | JJJ4M4D4                         | JJJ4M4D4                      | GGGG01NNNNNNNNNN                         | GGGG20NNNNNNNNN2                      |
            Als bewoning wordt gevraagd met /bewoningen/GGGG01NNNNNNNNNN?datumVan=1900-01-01&datumTotEnMet=2021-09-30
            Dan bevat het antwoord 1 adres
            En bevat het antwoord het adres met nummeraanduidingIdentificatie "GGGG20NNNNNNNNN2"
