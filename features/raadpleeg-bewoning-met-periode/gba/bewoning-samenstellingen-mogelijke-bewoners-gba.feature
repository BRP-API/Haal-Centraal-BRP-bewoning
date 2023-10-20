#language: nl

@gba
Functionaliteit: Bewoningsamenstellingen met mogelijke bewoners
  Elke wijziging van de samenstelling van bewoners en mogelijke bewoners van een adresseerbaar object leidt tot een bewoning

    Achtergrond:
      Gegeven adres 'A1' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'A2' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |
      En adres 'A3' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |


  Rule: Bij de start en na afloop van de onzekerheidsperiode van datum aanvang ontstaat een nieuwe bewoning(samenstelling)
      - De eerste dag van de onzekerheidsperiode van datum aanvang wordt de persoon mogelijke bewoner en ontstaat een nieuwe bewoning(samenstelling)
      - Vanaf de eerste dag na de onzekerheidsperiode van datum aanvang wordt de persoon bewoner en ontstaat een nieuwe bewoning(samenstelling)

    Scenario: Datum aanvang is onbekend en periode begint in de onzekerheidsperiode en loopt door na de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2010-07-01         |
      | datumTot                         | 2012-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-07-01 tot 2011-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2011-01-01 tot 2012-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |

    Scenario: Datum aanvang is onbekend en periode begint voor de onzekerheidsperiode en loopt door na de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2012-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2009-12-01 tot 2010-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2011-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2011-01-01 tot 2012-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |


  Rule: Bij de start en na afloop van de onzekerheidsperiode van datum aanvang volgende verblijfplaats ontstaat een nieuwe bewoning(samenstelling)
      - De eerste dag van de onzekerheidsperiode van datum aanvang wordt de persoon mogelijke bewoner en ontstaat een nieuwe bewoning(samenstelling)
      - Vanaf de eerste dag na de onzekerheidsperiode van datum aanvang is de persoon geen bewoner meer en ontstaat een nieuwe bewoning(samenstelling) als er op dat moment ten minste één andere bewoner is

    Scenario: Datum aanvang volgende verblijfplaats is onbekend en periode loopt door tot in de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2010-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2009-12-01 tot 2010-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

    Scenario: Datum aanvang volgende verblijfplaats is onbekend en periode loopt door tot na de onzekerheidsperiode
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2011-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2009-12-01 tot 2010-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2011-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2011-01-01 tot 2011-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

  Rule: Als er tijdens de onzekerheidsperiode van een bewoner een andere bewoner in- of uitverhuist, ontstaat op de datum aanvang van de andere bewoner een nieuwe bewoning(samenstelling)

    Scenario: Datum aanvang is onbekend en tijdens de onzekerheidsperiode komt een andere bewoner op het adres wonen
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100201                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2010-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-02-01 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: Datum aanvang is onbekend en tijdens de onzekerheidsperiode verhuist een andere bewoner naar een ander adres
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100201                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2010-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2009-12-01 tot 2010-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-02-01 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: Datum aanvang volgende verblijfplaats is onbekend en tijdens de onzekerheidsperiode komt een andere bewoner op het adres wonen
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100210                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2010-01-01         |
      | datumTot                         | 2010-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-02-10 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-02-10 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: Datum aanvang volgende verblijfplaats is onbekend en tijdens de onzekerheidsperiode verhuist een andere bewoner naar een ander adres
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100201                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2010-03-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2009-12-01 tot 2010-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-02-01 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: Datum aanvang is onbekend en overlapt de ook onbekende datum aanvang van een andere bewoner
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100200                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2010-12-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-02-01 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-03-01 tot 2010-12-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: Datum aanvang is onbekend en overlapt de ook onbekende datum aanvang volgende verblijf van een andere bewoner
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20080526                           |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100000                           |
      En de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20010410                           |
      En de persoon is vervolgens ingeschreven op adres 'A3' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20100200                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-12-01         |
      | datumTot                         | 2010-12-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000002   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2009-12-01 tot 2010-01-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-01-01 tot 2010-02-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-02-01 tot 2010-03-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning mogelijke bewoners met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |
      | 000000024           |
      En heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2010-03-01 tot 2010-12-01 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

  Rule: Rule: meerdere aaneensluitende verblijfplaatsen op hetzelfde adresseerbaar object, met dezelfde (mogelijke) bewoners, wordt als één bewoning geleverd

    Abstract Scenario: persoon heeft onbekende aanvang adreshouding en daar direct op aansluitende onbekende aanvang volgende adreshouding en periode overlapt de onzekerheidsperiodes
      Gegeven de persoon met burgerservicenummer '000000024' is ingeschreven op adres 'A1' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | <datum aanvang adreshouding>       |
      En de persoon is vervolgens ingeschreven op adres 'A2' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30)    |
      | 0800                              | <datum aanvang volgende adreshouding> |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde             |
      | type                             | BewoningMetPeriode |
      | datumVan                         | 2009-07-01         |
      | datumTot                         | 2011-07-01         |
      | adresseerbaarObjectIdentificatie | 0800010000000001   |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                      |
      | periode                          | <datum van> tot <datum tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000001            |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000024           |

      Voorbeelden:
      | datum aanvang adreshouding | datum aanvang volgende adreshouding | datum van  | datum tot  |
      | 20100800                   | 20100900                            | 2010-08-01 | 2010-10-01 |
      | 20101200                   | 20110000                            | 2010-12-01 | 2012-01-01 |
      | 20100000                   | 20110100                            | 2010-01-01 | 2011-02-01 |
      | 20100000                   | 20110000                            | 2010-01-01 | 2012-01-01 |
