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
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep            |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102 |

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
    | stap | categorie      | text                                                                                                                                                  | values                |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep             |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012  |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000013 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 10000,4999,0,20230203 |

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
    | stap | categorie      | text                                                                                                                                                  | values               |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001     |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067002     |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                    |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,1,20230102 |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,5000,0,20230601 |

  Scenario: veel inschrijvingen op een adres
    Gegeven adres 'A1' heeft de volgende gegevens
    | naam               | waarde    |
    | straatnaam (11.10) | Boterdiep |
    En er zijn 3 personen ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20230102                           |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep             |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000001  |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,0,20230102  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000002 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 10000,4999,0,20230102 |
    | 4    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                     |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10001,0,0,P,000000003 |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 10001,4999,0,20230102 |

  Scenario: een adres met identificatie wordt gewijzigd
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En adres 'A1' is op '2023-02-03' gewijzigd naar de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie | text                                                                                                                                                 | values           |
    | 1    | adres-A1  | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                | Boterdiep        |
    |      | adres-2   | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING * | 0800010011067001 |

  Scenario: een inschrijving op een adres met identificatie dat wordt gewijzigd
    Gegeven adres 'A1' heeft de volgende gegevens
    | straatnaam (11.10) |
    | Boterdiep          |
    En de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
    | datum aanvang adreshouding (10.30) |
    | 20220102                           |
    En adres 'A1' is op '2023-02-03' gewijzigd naar de volgende gegevens
    | identificatiecode verblijfplaats (11.80) |
    | 0800010011067001                         |
    Dan zijn de gegenereerde SQL statements
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,straat_naam) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *                 | Boterdiep              |
    |      | adres-2        | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001       |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,1,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5)            | 9999,5000,0,20230203,W |

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
    | stap | categorie      | text                                                                                                                                                  | values                 |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001       |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067002       |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                      |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,1,20220102   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5)            | 9999,5000,0,20230203,W |

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
    | stap | categorie      | text                                                                                                                                                  | values                  |
    | 1    | adres-A1       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067001        |
    |      | adres-A2       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067002        |
    |      | adres-A3       | INSERT INTO public.lo3_adres(adres_id,verblijf_plaats_ident_code) VALUES((SELECT COALESCE(MAX(adres_id), 0)+1 FROM public.lo3_adres),$1) RETURNING *  | 0800010011067003        |
    | 2    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 9999,0,0,P,000000012    |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 9999,4999,1,20220102    |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5)            | 9999,5001,0,20230203,W  |
    | 3    | inschrijving   | INSERT INTO public.lo3_pl(pl_id,mutatie_dt,geheim_ind) VALUES((SELECT COALESCE(MAX(pl_id), 0)+1 FROM public.lo3_pl),current_timestamp,$1) RETURNING * | 0                       |
    |      | persoon        | INSERT INTO public.lo3_pl_persoon(pl_id,stapel_nr,volg_nr,persoon_type,burger_service_nr) VALUES($1,$2,$3,$4,$5)                                      | 10000,0,0,P,000000024   |
    |      | verblijfplaats | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum) VALUES($1,$2,$3,$4)                                         | 10000,5000,1,20211201   |
    |      |                | INSERT INTO public.lo3_pl_verblijfplaats(pl_id,adres_id,volg_nr,adreshouding_start_datum,aangifte_adreshouding_oms) VALUES($1,$2,$3,$4,$5)            | 10000,5001,0,20230203,W |

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