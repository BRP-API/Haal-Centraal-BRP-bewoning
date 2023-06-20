#language: nl

Functionaliteit: raadpleeg bewoning in periode

  Scenario: gevraagde periode valt volledig in de bewoning van de bewoner
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    | 0518010000854789                         | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2012-01-01                                                                                            |
    | datumTot                         | 2013-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2012-01-01 tot 2013-01-01' de volgende bewoners
    | burgerservicenummer |
    | 555550001           |

  Scenario: gevraagde periode valt volledig in de bewoning van de bewoner en bewoner verblijft nog op het adresseerbaar object
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2012-01-01                                                                                            |
    | datumTot                         | 2013-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2012-01-01 tot 2013-01-01' de volgende bewoners
    | burgerservicenummer |
    | 555550001           |

  Scenario: gevraagde periode valt niet in de bewoning van de bewoner
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    | 0518010000854789                         | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2016-06-01                                                                                            |
    | datumTot                         | 2017-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2016-06-01 tot 2017-01-01' geen bewoners

  Scenario: gevraagde periode valt deels in de bewoning van de bewoner
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100818                           |
    | 0518010000854789                         | 20160526                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2016-01-01                                                                                            |
    | datumTot                         | 2017-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2016-01-01 tot 2016-05-26' de volgende bewoners
    | burgerservicenummer |
    | 555550001           |
    En heeft de bewoning voor de periode '2016-05-26 tot 2017-01-01' geen bewoners

  Scenario: dag datum aanvang adreshouding is onbekend en gevraagde periode bevat deze datum niet
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2010-09-01                                                                                            |
    | datumTot                         | 2011-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2010-09-01 tot 2011-01-01' de volgende bewoners
    | burgerservicenummer |
    | 555550001           |

  Scenario: dag datum aanvang adreshouding is onbekend en gevraagde periode overlapt deze datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2010-01-01                                                                                            |
    | datumTot                         | 2011-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2010-01-01 tot 2010-08-01' geen bewoners
    En heeft de bewoning voor de periode '2010-08-01 tot 2010-09-01' de volgende mogelijke bewoners
    | burgerservicenummer |
    | 555550001           |
    En heeft de bewoning voor de periode '2010-09-01 tot 2011-01-01' de volgende bewoners
    | burgerservicenummer |
    | 555550001           |

  Scenario: dag datum aanvang adreshouding is onbekend en gevraagde periode overlapt deels de periode van deze datum
    Gegeven het systeem heeft een persoon met de volgende gegevens
    | naam                | waarde    |
    | burgerservicenummer | 555550001 |
    En de persoon heeft de volgende verblijfplaatsen
    | identificatiecode verblijfplaats (11.80) | datum aanvang adreshouding (10.30) |
    | 0518010000713450                         | 20100800                           |
    Als bewoning wordt gezocht met de volgende parameters
    | naam                             | waarde                                                                                                |
    | type                             | BewoningMetPeriode                                                                                    |
    | datumVan                         | 2010-08-14                                                                                            |
    | datumTot                         | 2011-01-01                                                                                            |
    | adresseerbaarObjectIdentificatie | 0518010000713450                                                                                      |
    | fields                           | adresseerbaarObjectIdentificatie,bewoningPeriode.periode,bewoningPeriode.bewoners.burgerservicenummer |
    Dan heeft de response een bewoning met de volgende gegevens
    | naam                             | waarde           |
    | adresseerbaarObjectIdentificatie | 0518010000713450 |
    En heeft de bewoning voor de periode '2010-08-14 tot 2010-09-01' de volgende mogelijke bewoners
    | burgerservicenummer |
    | 555550001           |
    En heeft de bewoning voor de periode '2010-09-01 tot 2011-01-01' de volgende bewoners
    | burgerservicenummer |
    | 555550001           |
