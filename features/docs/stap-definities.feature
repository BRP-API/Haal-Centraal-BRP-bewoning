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
    En de 3e 'SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres' statement heeft als resultaat '5001'
    En de 1e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '9999'
    En de 2e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10000'
    En de 3e 'SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl' statement heeft als resultaat '10001'

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

  Scenario: Persoon heeft 'inschrijving' en 'gezagsverhouding' gegevens
    Gegeven de persoon met burgerservicenummer '000000012' heeft de volgende 'inschrijving' gegevens
    | indicatie geheim (70.10) | aanduiding uitgesloten kiesrecht (38.10) |
    | 7                        | A                                        |
    En de persoon heeft de volgende 'gezagsverhouding' gegevens
    | indicatie gezag minderjarige (32.10) |
    | 12                                   |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie        | text                                                                                                                                                                            | values               |
    | 1    | inschrijving     | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind,kiesrecht_uitgesl_aand) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1,$2) RETURNING * | 7,A                  |
    |      | persoon          | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                | 9999,0,0,P,000000012 |
    |      | gezagsverhouding | INSERT INTO public.lo3_pl_gezagsverhouding(pl_id,volg_nr,minderjarig_gezag_ind) VALUES($1,$2,$3)                                                                                | 9999,0,12            |

  Scenario: een adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                  | values    |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | Boterdiep |

  Scenario: meerdere adressen
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                | Boterdiep        |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |

  Scenario: een inschrijving op een adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep              |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,W,20230102 |

  Scenario: meerdere inschrijvingen op een adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | naam               | waarde    |
    | straatnaam (11.10) | Boterdiep |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de persoon met burgerservicenummer '000000013' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230203                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                  |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep               |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,W,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000013   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 10000,4999,0,W,20230203 |

  Scenario: een verhuizing
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230601                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001       |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067002       |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,1,W,20230102 |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,5000,0,W,20230601 |

  Scenario: veel inschrijvingen op een adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | naam               | waarde    |
    | straatnaam (11.10) | Boterdiep |
    En er zijn 3 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                  |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep               |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000001    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,W,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000002   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 10000,4999,0,W,20230102 |
    | 4    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10001,0,0,P,000000003   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 10001,4999,0,W,20230102 |

  Scenario: een adres wordt geactualiseerd
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A1' is op '2023-02-03' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                                | values                     |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                               | Boterdiep                  |
    |      | adres-2   | INSERT INTO public.lo3_adres(adres_id,straat_naam,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | Boterdiep,0800010011067001 |

  Scenario: een inschrijving op een adres met identificatie dat wordt geactualiseerd
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' geactualiseerd met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                | values                     |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                               | Boterdiep                  |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,straat_naam,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | Boterdiep,0800010011067001 |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *               | 0                          |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                    | 9999,0,0,P,000000012       |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                                      | 9999,4999,1,W,20220102     |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6)         | 9999,5000,0,W,20230203,T   |

  Scenario: een inschrijving op een adres met identificatie dat wordt samengevoegd
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' samengevoegd tot adres 'A2' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                        | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067001         |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067002         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 9999,4999,1,W,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 9999,5000,0,W,20230203,W |

  Scenario: een inschrijving op meerdere adressen met identificatie die worden samengevoegd
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    Gegeven adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067002                         |
    En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20211201                           |
    En de adressen 'A1, A2' zijn op '2023-02-03' samengevoegd tot adres 'A3' met de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067003                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                        | values                    |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067001          |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067002          |
    |      | adres-A3       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *        | 0800010011067003          |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                         |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 9999,0,0,P,000000012      |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 9999,4999,1,W,20220102    |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 9999,5001,0,W,20230203,W  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *       | 0                         |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                            | 10000,0,0,P,000000024     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                              | 10000,5000,1,W,20211201   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6) | 10000,5001,0,W,20230203,W |

  Scenario: een adres met identificatie wordt gesplitst
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En adres 'A1' is gesplitst in adressen met de volgende gegevens
    | adres | identificatiecode verblijfplaats (11.80) |
    | A2    | 0800010011067002                         |
    | A3    | 0800010011067003                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |
    |      | adres-A2  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067002 |
    |      | adres-A3  | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067003 |

  Scenario: een emigratie
    Gegeven adres 'A1' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En de 'verblijfplaats' is gewijzigd naar de volgende gegevens
    | land (13.10) | datum aanvang adres buitenland (13.20) |
    | 5010         | 20230526                               |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001       |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,1,W,20220102 |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,volg_nr,vertrek_land_code,vertrek_datum) VALUES($1,$2,$3,$4)                                           | 9999,0,5010,20230526   |

  Scenario: een gemeente
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9999                 | Ons Dorp             |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie   | text                                                                       | values        |
    | 1    | gemeente-G1 | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam) VALUES($1,$2) | 9999,Ons Dorp |

  Scenario: een gemeente dat is samengevoegd
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9999                 | Ons Dorp             |
    En gemeente 'G1' is samengevoegd met de volgende gegevens
    | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
    | 0800                        | 20230526                  |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie   | text                                                                                                                         | values                      |
    | 1    | gemeente-G1 | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam,nieuwe_gemeente_code,tabel_regel_eind_datum) VALUES($1,$2,$3,$4) | 9999,Ons Dorp,0800,20230526 |

  Scenario: een gemeente met een adres dat is samengevoegd
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9999                 | Ons Dorp             |
    En adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 9999                 | 9999010000000003                         |
    En gemeente 'G1' is samengevoegd met de volgende gegevens
    | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
    | 0800                        | 20230526                  |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie   | text                                                                                                                                                                  | values                      |
    | 1    | gemeente-G1 | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam,nieuwe_gemeente_code,tabel_regel_eind_datum) VALUES($1,$2,$3,$4)                                          | 9999,Ons Dorp,0800,20230526 |
    | 2    | adres-A1    | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 9999,9999010000000003       |
    |      | adres-2     | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING * | 0800,9999010000000003       |

  Scenario: een gemeente met verblijfplaats dat is samengevoegd
    Gegeven gemeente 'G1' heeft de volgende gegevens
    | gemeentecode (92.10) | gemeentenaam (92.11) |
    | 9000                 | Ons Dorp             |
    En adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 9000                 | 9999010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 9000                              | 20220102                           |
    En gemeente 'G1' is samengevoegd met de volgende gegevens
    | nieuwe gemeentecode (92.12) | datum beëindiging (99.99) |
    | 0800                        | 20230526                  |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                                      | values                        |
    | 1    | gemeente-G1    | INSERT INTO public.lo3_gemeente(gemeente_code,gemeente_naam,nieuwe_gemeente_code,tabel_regel_eind_datum) VALUES($1,$2,$3,$4)                                                              | 9000,Ons Dorp,0800,20230526   |
    | 2    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 9000,9999010000000003         |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0800,9999010000000003         |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                     | 0                             |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                          | 9999,0,0,P,000000012          |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5,$6)                              | 9999,4999,1,W,9000,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,5000,0,W,0800,20230526,W |

  Scenario: een inschrijving op een adres met identificatie dat infrastructureel wordt gewijzigd
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220102                           |
    En adres 'A1' is op '2023-02-03' infrastructureel gewijzigd met de volgende gegevens
    | gemeentecode (92.10) |
    | 0530                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                                      | values                        |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0800,0800010000000003         |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0530,0800010000000003         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                     | 0                             |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                          | 9999,0,0,P,000000012          |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5,$6)                              | 9999,4999,1,W,0800,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,5000,0,W,0530,20230203,W |

  Scenario: een inschrijving op een adres met identificatie dat infrastructureel wordt gewijzigd naar een adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
    | 0800                 | 0800010000000003                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
    | 0800                              | 20220102                           |
    En adres 'A1' is op '2023-02-03' infrastructureel gewijzigd naar adres 'A2' met de volgende gegevens
    | gemeentecode (92.10) |
    | 0530                 |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                                                      | values                        |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0800,0800010000000003         |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,gemeente_code,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1,$2) RETURNING *                     | 0530,0800010000000003         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING *                                     | 0                             |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                                                          | 9999,0,0,P,000000012          |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5,$6)                              | 9999,4999,1,W,0800,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,inschrijving_gemeente_code,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5,$6,$7) | 9999,5000,0,W,0530,20230203,W |

  Scenario: een correctie op een inschrijving op een adres met identificatie 
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A2' heeft de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    En de inschrijving is vervolgens gecorrigeerd als een inschrijving op adres 'A2' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230800                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                   |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001         |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                        |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012     |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum,onjuist_ind) VALUES($1,$2,$3,$4,$5,$6)         | 9999,4999,1,W,20230102,O |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,5000,0,W,20230800   |

  Scenario: persoon heeft kind
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | kind-1       | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Jansen    |

  Scenario: persoon heeft kind en inschrijving op een adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep            |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | kind-1         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Jansen    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102 |

  Abstract Scenario: persoon heeft ouder
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder-type>' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie          | text                                                                                                                                                  | values                       |
    | 1    | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                            |
    |      | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012         |
    |      | ouder-<ouder-type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,<ouder-type>,Jansen |

    Voorbeelden:
    | ouder-type |
    | 1          |
    | 2          |

  Scenario: persoon met 2 ouders
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | naam                  | waarde    |
    | geslachtsnaam (02.40) | Pietersen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | ouder-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,1,Jansen    |
    |      | ouder-2      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,2,Pietersen |

  Abstract Scenario: persoon heeft ouder en inschrijving op een adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft een ouder '<ouder-type>' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie          | text                                                                                                                                                  | values                       |
    | 1    | adres-A1           | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep                    |
    | 2    | inschrijving       | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                            |
    |      | persoon            | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012         |
    |      | ouder-<ouder-type> | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,<ouder-type>,Jansen |
    |      | verblijfplaats     | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102         |

    Voorbeelden:
    | ouder-type |
    | 1          |
    | 2          |

  Scenario: persoon heeft partner
    Gegeven de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie    | text                                                                                                                                                  | values               |
    | 1    | inschrijving | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | partner-1    | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,R,Jansen    |

  Scenario: persoon heeft partner en inschrijving op een adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft een 'partner' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep            |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | partner-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,R,Jansen    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102 |

  Scenario: persoon heeft ouder, partner, kind en inschrijving op een adres met identificatie
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon heeft een 'partner' met de volgende gegevens
    | naam                  | waarde    |
    | geslachtsnaam (02.40) | Pietersen |
    En de persoon heeft een 'kind' met de volgende gegevens
    | naam                  | waarde |
    | geslachtsnaam (02.40) | Jansen |
    En de persoon is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep            |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | ouder-1        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,1,Jansen    |
    |      | partner-1      | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,R,Pietersen |
    |      | kind-1         | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,geslachts_naam) VALUES($1,$2,$3,$4,$5)                                         | 9999,0,0,K,Jansen    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102 |

  Scenario: een adres opgeven als briefadres
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' heeft adres 'A1' als briefadres opgegeven met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep              |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adres_functie,adreshouding_start_datum) VALUES($1,$2,$3,$4,$5)                        | 9999,4999,0,B,20230102 |
