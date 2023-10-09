using HaalCentraal.BewoningService.Entities;
using HaalCentraal.BewoningService.Generated;

namespace HaalCentraal.BewoningService.Repositories;

public static class PersoonQueryExtensions
{
    public static Specification<Persoon> ToSpecification(this BewoningMetPeildatum query)
    {
        return new AdresseerbaarObjectIdentificatieSpecification(query.AdresseerbaarObjectIdentificatie!)
            .And(new PeildatumSpecification(query.Peildatum!))
            ;
    }

    public static Specification<Persoon> ToSpecification(this BewoningMetPeriode query)
    {
        return new AdresseerbaarObjectIdentificatieSpecification(query.AdresseerbaarObjectIdentificatie!)
            .And(new PeriodeSpecification(query.DatumVan!, query.DatumTot!))
            ;
    }
}
