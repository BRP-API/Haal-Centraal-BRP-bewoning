#language: nl

Functionaliteit: Bewoning

    Als ambtenaar
    Wil ik de bewoning van een adresseerbaar object in een periode kunnen opvragen
    Zodat ik kan bepalen welke personen in de opgegeven periode op de adressen van het adresseerbaar object hebben gewoond

    Scenario: Geen personen wonen op het adresseerbaar object in de gevraagde periode
        Gegeven er wonen geen personen op het adresseerbaar object in de gevraagde periode
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |              |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-12-31    |              |

    Scenario: Persoon woont op het adresseerbaar object in de gevraagde periode
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2021-01-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    | 99999XXXX    |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-12-31    | 99999XXXX    |

    Scenario: Persoon woont op het adresseerbaar object in een deel van de gevraagde periode
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2020-12-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-11-30    | 99999XXXX    |
        | 0518010000412416                 | 2020-12-01 | 2020-12-31    |              |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-12-31    | 99999XXXX    |
        | 2020-12-01 | 2020-12-31    |              |

    Scenario: Persoon woont langer op het adresseerbaar object dan de gevraagde periode
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2021-01-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-03-01 | 2020-10-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-03-01 | 2020-10-31    | 99999XXXX    |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-03-01 | 2020-10-31    | 99999XXXX    |

    Scenario: Meerdere personen wonen op het adresseerbaar object in de gevraagde periode
        Gegeven de personen
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2021-01-01              |
        | 99999YYYY | 0518010000412416                                | 2020-01-01                              | 2021-01-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners         |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    | 99999XXXX, 99999YYYY |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners         |
        | 2020-01-01 | 2020-12-31    | 99999XXXX, 99999YYYY |

    Scenario: Meerdere personen wonen op het adresseerbaar object in een deel van de gevraagde periode
        Gegeven de personen
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2021-10-01              |
        | 99999YYYY | 0518010000412416                                | 2020-04-01                              | 2021-01-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners         |
        | 0518010000412416                 | 2020-01-01 | 2020-03-31    | 99999XXXX            |
        | 0518010000412416                 | 2020-04-01 | 2020-09-30    | 99999XXXX, 99999YYYY |
        | 0518010000412416                 | 2020-10-01 | 2020-12-31    | 99999YYYY            |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners         |
        | 2020-01-01 | 2020-03-31    | 99999XXXX            |
        | 2020-04-01 | 2020-09-30    | 99999XXXX, 99999YYYY |
        | 2020-10-01 | 2020-12-31    | 99999YYYY            |

    Scenario: dag datumTot is onbekend: datumTot is eerste dag van de volgende maand
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot.jaar | verblijfplaats.datumTot.maand | verblijfplaats.datumTot.dag |
        | 99999XXXX | 0518010000412416                                | 2020-04-01                              | 2020                         | 10                            |                             |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-03-31    |              |
        | 0518010000412416                 | 2020-04-01 | 2020-10-31    | 99999XXXX    |
        | 0518010000412416                 | 2020-11-01 | 2020-12-31    |              |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-03-31    |              |
        | 2020-04-01 | 2020-10-31    | 99999XXXX    |
        | 2020-11-01 | 2020-12-31    |              |

    Scenario: maand en dag DatumTot is onbekend: datumTot is eerste dag van het volgend jaar
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot.jaar | verblijfplaats.datumTot.maand | verblijfplaats.datumTot.dag |
        | 99999XXXX | 0518010000412416                                | 2020-04-01                              | 2020                         |                               |                             |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-03-31    |              |
        | 0518010000412416                 | 2020-04-01 | 2020-12-31    | 99999XXXX    |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-03-31    |              |
        | 2020-04-01 | 2020-12-31    | 99999XXXX    |

    Scenario: datumTot is geheel onbekend + indicatieDatumTotOnbekend=true: bewoner wordt niet meegenomen
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot | verblijfplaats.indicatieDatumTotOnbekend |
        | 99999XXXX | 0518010000412416                                | 2020-04-01                              |                         | true                                     |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |              | 99999XXXX                  |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 2020-01-01 | 2020-12-31    |              | 99999XXXX                  |

    Scenario: datumTot is geheel onbekend + indicatieDatumTotOnbekend=false: bewoner woont tot vandaag op het adres
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-04-01                              |                         |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    | 99999XXXX    |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-12-31    | 99999XXXX    |

    Scenario: Meerdere personen wonen op het adresseerbaar object, één met geheel onbekend datumTot
        Gegeven de personen
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2021-10-01              |
        | 99999YYYY | 0518010000412416                                | 2020-04-01                              |                         |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-03-31    | 99999XXXX    |                            |
        | 0518010000412416                 | 2020-04-01 | 2020-09-30    | 99999XXXX    | 99999YYYY                  |
        | 0518010000412416                 | 2020-10-01 | 2020-12-31    |              | 99999YYYY                  |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 2020-01-01 | 2020-03-31    | 99999XXXX    |                            |
        | 2020-04-01 | 2020-09-30    | 99999XXXX    | 99999YYYY                  |
        | 2020-10-01 | 2020-12-31    |              | 99999YYYY                  |

    Scenario: dag datumAanvangAdreshouding is onbekend: datumAanvangAdreshouding is eerste dag van de maand
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding.jaar | verblijfplaats.datumAanvangAdreshouding.maand | verblijfplaats.datumAanvangAdreshouding.dag | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020                                         | 04                                            |                                             | 2021-11-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-03-31    |              |
        | 0518010000412416                 | 2020-04-01 | 2020-10-31    | 99999XXXX    |
        | 0518010000412416                 | 2020-11-01 | 2020-12-31    |              |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-03-31    |              |
        | 2020-04-01 | 2020-10-31    | 99999XXXX    |
        | 2020-11-01 | 2020-12-31    |              |

    Scenario: maand en dag datumAanvangAdreshouding is onbekend: datumAanvangAdreshouding is eerste dag van het jaar
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding.jaar | verblijfplaats.datumAanvangAdreshouding.maand | verblijfplaats.datumAanvangAdreshouding.dag | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020                                         |                                               |                                             | 2021-11-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-10-31    | 99999XXXX    |
        | 0518010000412416                 | 2020-11-01 | 2020-12-31    |              |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-10-31    | 99999XXXX    |
        | 2020-11-01 | 2020-12-31    |              |

    Scenario: datumAanvangAdreshouding is geheel onbekend: bewoner wordt niet meegenomen
        Gegeven de persoon
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                |                                         | 2021-01-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |              | 99999XXXX                  |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 2020-01-01 | 2020-12-31    |              | 99999XXXX                  |

    Scenario: Meerdere personen wonen op het adresseerbaar object, één met geheel onbekend datumAanvangAdreshouding: bewoner wordt niet meegenomen
        Gegeven de personen
        | bsn       | verblijfplaats.adresseerbaarObjectIdentificatie | verblijfplaats.datumAanvangAdreshouding | verblijfplaats.datumTot |
        | 99999XXXX | 0518010000412416                                | 2020-01-01                              | 2020-10-01              |
        | 99999YYYY | 0518010000412416                                |                                         | 2021-01-01              |
        Als bewoningen wordt gevraagd met
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet |
        | 0518010000412416                 | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoningen
        | adresseerbaarObjectIdentificatie | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 0518010000412416                 | 2020-01-01 | 2020-03-31    | 99999XXXX    |                            |
        | 0518010000412416                 | 2020-04-01 | 2020-09-30    | 99999XXXX    | 99999YYYY                  |
        | 0518010000412416                 | 2020-10-01 | 2020-12-31    |              | 99999YYYY                  |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        En bevat de bewoning de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners | bsn nietMeegenomenBewoners |
        | 2020-01-01 | 2020-03-31    | 99999XXXX    |                            |
        | 2020-04-01 | 2020-09-30    | 99999XXXX    | 99999YYYY                  |
        | 2020-10-01 | 2020-12-31    |              | 99999YYYY                  |

    Scenario: Persoon heeft op verschillende adresseerbaar objecten gewoond in de gevraagde periode
        Gegeven de persoon
        | bsn       |
        | 99999XXXX |
        En de volgende verblijfplaatsen van de persoon
        | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | datumTot   |
        | 0518010000412416                 | 2020-01-01               | 2020-10-01 |
        | 0518010000781379                 | 2020-10-01               | 2021-01-01 |
        Als bewoningen wordt gevraagd met
        | bsn       | datumVan   | datumTotEnMet |
        | 99999XXXX | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        | 0518010000781379                 |
        En bevat de bewoning met adresseerbaarObjectIdentificatie 0518010000412416 de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-01-01 | 2020-09-30    | 99999XXXX    |
        En bevat de bewoning met adresseerbaarObjectIdentificatie 0518010000781379 de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners |
        | 2020-10-01 | 2020-12-31    | 99999XXXX    |

    Scenario: Persoon heeft op verschillende adresseerbaar objecten gewoond in de gevraagde periode heeft verschillende medebewoners in de gevraagde periode
        Gegeven de personen
        | bsn       |
        | 99999XXXX |
        | 99999YYYY |
        | 99999ZZZZ |
        En de volgende verblijfplaatsen van de persoon 99999XXXX
        | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | datumTot   |
        | 0518010000412416                 | 2020-01-01               | 2020-10-01 |
        | 0518010000781379                 | 2020-10-01               | 2021-01-01 |
        En de volgende verblijfplaatsen van de persoon 99999YYYY
        | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | datumTot   |
        | 0518010000781379                 | 2020-01-01               | 2020-06-01 |
        | 0518010000412416                 | 2020-06-01               | 2021-01-01 |
        En de volgende verblijfplaatsen van de persoon 99999ZZZZ
        | adresseerbaarObjectIdentificatie | datumAanvangAdreshouding | datumTot   |
        | 0518010000781379                 | 2020-01-01               | 2021-01-01 |
        Als bewoningen wordt gevraagd met
        | bsn       | datumVan   | datumTotEnMet |
        | 99999XXXX | 2020-01-01 | 2020-12-31    |

        Dan bevat het antwoord de volgende bewoning
        | adresseerbaarObjectIdentificatie |
        | 0518010000412416                 |
        | 0518010000781379                 |
        En bevat de bewoning met adresseerbaarObjectIdentificatie 0518010000412416 de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners        |
        | 2020-01-01 | 2020-05-31    | 99999XXXX           |
        | 2020-06-01 | 2020-09-30    | 99999XXXX,99999YYYY |
        En bevat de bewoning met adresseerbaarObjectIdentificatie 0518010000781379 de volgende bewoon periodes
        | datumVan   | datumTotEnMet | bsn bewoners        |
        | 2020-10-01 | 2020-12-31    | 99999XXXX,99999ZZZZ |
