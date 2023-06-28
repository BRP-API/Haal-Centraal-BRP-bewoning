using FluentValidation;
using HaalCentraal.BewoningProxy.Generated;

namespace BewoningProxy.Validators;

public class BewoningMetPeildatumValidator : AbstractValidator<BewoningMetPeildatum>
{
    public BewoningMetPeildatumValidator()
    {
        Include(new Bewoning.Validatie.Validators.BewoningMetPeildatumQueryValidator());
        Include(new Bewoning.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
