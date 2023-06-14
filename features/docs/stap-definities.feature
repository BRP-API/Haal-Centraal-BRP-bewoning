#language: nl

@stap-documentatie
Functionaliteit: Stap definities

  Om scenarios voor de BRP APIs te kunnen schrijven wordt in deze feature beschreven welke sql statements worden gegenereerd/uitgevoerd voor een Gegeven stap.
  Deze sql statements staan in de tabel van de  'Dan zijn de gegenereerde SQL statements' stap. Elke rij in de tabel geeft aan
  - bij welk gegeven stap (stap kolom geeft de stap aan binnen de scenario. 1 = 1e stap, 2 = 2e stap etc) de SQL statement hoort
  - bij welke BRP categorie (categorie kolom) de SQL statement hoort
  - wat de SQL statement is (text kolom)
  - welke waarden worden meegegeven bij het uitvoeren van de SQL statement (values kolom)

  Achtergrond:
    Gegeven de 1e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '4999'
    En de 2e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5000'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'

Rule: Gegeven de persoon met burgerservicenummer '<bsn>' heeft de volgende '<categorie>' gegevens

  Scenario: Persoon heeft 'inschrijving' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'inschrijving' gegevens
    | indicatie geheim (70.10) | aanduiding uitgesloten kiesrecht (38.10) |
    | 7                        | A                                        |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                                            | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * | 7,A                  |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                | 9999,0,0,P,000000012 |

  Scenario: Persoon heeft 'kiesrecht' gegevens
    kiesrecht is geen bestaande BRP categorie
    kiesrecht gegevens worden vastgelegd bij categorie inschrijving, kiesrecht wordt gebruikt als alias voor categorie inschrijving tbv begrip

    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'kiesrecht' gegevens
    | aanduiding uitgesloten kiesrecht (38.10) |
    | A                                        |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                                            | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * | 0,A                  |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                | 9999,0,0,P,000000012 |

    Scenario: Persoon heeft 'gezagsverhouding' gegevens
      Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'gezagsverhouding' gegevens
      | indicatie gezag minderjarige (32.10) |
      | 12                                   |
      Dan zijn de gegenereerde SQL statements
      | stap | categorie        | text                                                                                                                                                  | values               |
      | 1    | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
      |      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
      |      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                      | 9999,0,12            |

  Scenario: een adres
    Gegeven een adres heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                  | values    |
    | 1    | adres     | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | Boterdiep |

  Scenario: meerdere adressen
    Gegeven een adres heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En een adres heeft de volgende gegevens
    | locatiebeschrijving (12.10) |
    | Woonboot bij de Grote Sloot |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                           | values                      |
    | 1    | adres     | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *          | Boterdiep                   |
    | 2    | adres     | INSERT INTO public.lo3_adres(adres_id,locatie_beschrijving) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | Woonboot bij de Grote Sloot |

  Scenario: een inschrijving op een adres
    Gegeven een adres heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op het adres met 'straatnaam (11.10)' 'Boterdiep' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | adres          | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep            |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102 |

  Scenario: meerdere inschrijvingen op een adres
    Gegeven een adres heeft de volgende gegevens
    | naam               | waarde    |
    | straatnaam (11.10) | Boterdiep |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op het adres met 'straatnaam (11.10)' 'Boterdiep' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de persoon met burgerservicenummer '000000013' is ingeschreven op het adres met 'straatnaam (11.10)' 'Boterdiep' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230203                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                |
    | 1    | adres          | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep             |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012  |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000013 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 10000,4999,0,20230203 |

  Scenario: een verhuizing (nieuwe manier)
    Gegeven een adres heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En een adres heeft de volgende gegevens
    | locatiebeschrijving (12.10) |
    | Woonboot bij de Grote Sloot |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op het adres met 'straatnaam (11.10)' 'Boterdiep' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de persoon is vervolgens ingeschreven op het adres met 'locatiebeschrijving (12.10)' 'Woonboot bij de Grote Sloot' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230601                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                      |
    | 1    | adres          | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                   |
    | 2    | adres          | INSERT INTO public.lo3_adres(adres_id,locatie_beschrijving) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | Woonboot bij de Grote Sloot |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                           |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012        |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,1,20230102        |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,5000,0,20230601        |
