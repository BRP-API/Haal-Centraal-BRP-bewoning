using Bewoning.Validatie;
using HaalCentraal.BewoningService.Entities;
using System.Linq.Expressions;

namespace HaalCentraal.BewoningService.Repositories;

public class PeildatumSpecification : Specification<Persoon>
{
    private readonly DateTimeOffset _peildatum;

    public PeildatumSpecification(string peildatum)
    {
        _peildatum = peildatum.ToDateTimeOffset();
    }

    public override Expression<Func<Persoon, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                          persoon.Verblijfplaats != null &&
                          persoon.Verblijfplaats.DatumAanvangAdreshouding != null &&
                          persoon.Verblijfplaats.DatumAanvangAdreshouding.ToNumber() <= _peildatum.ToNumber() &&
                          (persoon.Verblijfplaats.DatumEindeAdreshouding == null
                           ||
                           (persoon.Verblijfplaats.DatumEindeAdreshouding != null &&
                            persoon.Verblijfplaats.DatumEindeAdreshouding.ToNumber() > _peildatum.ToNumber()
                           )
                          );
    }
}
