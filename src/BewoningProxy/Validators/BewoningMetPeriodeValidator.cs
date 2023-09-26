using FluentValidation;
using HaalCentraal.BewoningProxy.Generated;

namespace BewoningProxy.Validators;

public class BewoningMetPeriodeValidator : AbstractValidator<BewoningMetPeriode>
{
    public BewoningMetPeriodeValidator()
    {
        Include(new Bewoning.Validatie.Validators.BewoningMetPeriodeQueryValidator());
        Include(new Bewoning.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
