using FluentValidation;
using HaalCentraal.BewoningService.Generated;

namespace HaalCentraal.BewoningService.Validators;

public class BewoningMetPeildatumValidator : AbstractValidator<BewoningMetPeildatum>
{
    public BewoningMetPeildatumValidator()
    {
        Include(new Bewoning.Validatie.Validators.BewoningMetPeildatumQueryValidator());
    }
}
