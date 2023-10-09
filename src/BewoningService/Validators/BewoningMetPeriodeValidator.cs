using FluentValidation;
using HaalCentraal.BewoningService.Generated;

namespace HaalCentraal.BewoningService.Validators;

public class BewoningMetPeriodeValidator : AbstractValidator<BewoningMetPeriode>
{
    public BewoningMetPeriodeValidator()
    {
        Include(new Bewoning.Validatie.Validators.BewoningMetPeriodeQueryValidator());
    }
}
