using HaalCentraal.BewoningService.Entities;
using System.Linq.Expressions;

namespace HaalCentraal.BewoningService.Repositories;

public class AdresseerbaarObjectIdentificatieSpecification : Specification<Persoon>
{
    private readonly string _adresseerbaarObjectIdentificatie;

    public AdresseerbaarObjectIdentificatieSpecification(string adresseerbaarObjectIdentificatie)
    {
        _adresseerbaarObjectIdentificatie = adresseerbaarObjectIdentificatie;
    }

    public override Expression<Func<Persoon, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                          persoon.Verblijfplaats != null &&
                          !string.IsNullOrEmpty(persoon.Verblijfplaats.AdresseerbaarObjectIdentificatie) &&
                          persoon.Verblijfplaats.AdresseerbaarObjectIdentificatie == _adresseerbaarObjectIdentificatie;
    }
}
