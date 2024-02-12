#language: nl

@gba
Functionaliteit: begin- en einddatum bepalen bij een briefadres voor bewoning op peildatum

    Achtergrond:
      Gegeven adres 'vorige' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000001                         |
      En adres 'gevraagd' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000002                         |
      En adres 'volgende' heeft de volgende gegevens
      | gemeentecode (92.10) | identificatiecode verblijfplaats (11.80) |
      | 0800                 | 0800010000000003                         |


    Abstract Scenario: verblijfplaats met gedeeltelijk onbekende datum aanvang en vorige verblijfplaats is briefadres met <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' heeft adres 'vorige' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | peildatum  | scenario                                                      |
      | 2022-05-26 | peildatum is datum aanvang vorige                             |
      | 2022-01-01 | peildatum voor datum aanvang vorige en in onzekerheidsperiode |

    Abstract Scenario: verblijfplaats met gedeeltelijk onbekende datum aanvang en vorige verblijfplaats is briefadres met <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' heeft adres 'vorige' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | peildatum  | periode tot | scenario                              |
      | 2022-05-27 | 2022-05-28  | peildatum dag na datum aanvang vorige |
      | 2022-07-30 | 2022-07-31  | peildatum na datum aanvang vorige     |

    Abstract Scenario: verblijfplaats met gedeeltelijk onbekende datum aanvang en vorige verblijfplaats is briefadres met <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' heeft adres 'vorige' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220526                           |
      En de persoon is vervolgens ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220000                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | peildatum  | periode tot | scenario                              |
      | 2023-01-01 | 2023-01-02  | peildatum na onzekerheidsperiode      |

    Scenario: volgende verblijfplaats is briefadres en peildatum is datum aanvang van volgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon heeft vervolgens adres 'volgende' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-10           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

    Scenario: volgende verblijfplaats is briefadres en peildatum is dag voor datum aanvang van volgende verblijfplaats
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon heeft vervolgens adres 'volgende' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | 2022-08-09           |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                    |
      | periode                          | 2022-08-09 tot 2022-08-10 |
      | adresseerbaarObjectIdentificatie | 0800010000000002          |
      En heeft de bewoning een bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

    Scenario: verblijfplaats wijzigt van woonadres naar briefadres en <scenario>
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon heeft vervolgens adres 'gevraagd' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220810                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response 0 bewoningen

      Voorbeelden:
      | peildatum  | scenario                                      |
      | 2022-08-10 | peildatum is datum aanvang van het briefadres |
      | 2022-09-01 | peildatum na datum aanvang van het briefadres |

    Scenario: volgende verblijfplaats met gedeeltelijk onbekende datum aanvang is briefadres
      Gegeven de persoon met burgerservicenummer '000000012' is ingeschreven op adres 'gevraagd' met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20160526                           |
      En de persoon heeft vervolgens adres 'volgende' als briefadres opgegeven met de volgende gegevens
      | gemeente van inschrijving (09.10) | datum aanvang adreshouding (10.30) |
      | 0800                              | 20220800                           |
      Als gba bewoning wordt gezocht met de volgende parameters
      | naam                             | waarde               |
      | type                             | BewoningMetPeildatum |
      | peildatum                        | <peildatum>          |
      | adresseerbaarObjectIdentificatie | 0800010000000002     |
      Dan heeft de response een bewoning met de volgende gegevens
      | naam                             | waarde                        |
      | periode                          | <peildatum> tot <periode tot> |
      | adresseerbaarObjectIdentificatie | 0800010000000002              |
      En heeft de bewoning een mogelijke bewoner met de volgende gegevens
      | burgerservicenummer |
      | 000000012           |

      Voorbeelden:
      | peildatum  | periode tot | scenario                                                        |
      | 2022-08-01 | 2022-08-02  | peildatum is eerste dag onzekerheidsperiode van het briefadres  |
      | 2022-08-31 | 2022-09-01  | peildatum is laatste dag onzekerheidsperiode van het briefadres |
