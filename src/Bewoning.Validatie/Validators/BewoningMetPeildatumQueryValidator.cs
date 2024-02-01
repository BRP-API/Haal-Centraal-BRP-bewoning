using Bewoning.Validatie.Interfaces;
using FluentValidation;

namespace Bewoning.Validatie.Validators;

public class BewoningMetPeildatumQueryValidator : AbstractValidator<IBewoningMetPeildatumQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string AdresseerbaarObjectIdentificatiePattern = @"^(?!0{16})[0-9]{16}$";
    const string AdresseerbaarObjectIdentificatieErrorMessage = $"pattern||Waarde voldoet niet aan patroon {AdresseerbaarObjectIdentificatiePattern}.";
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";

    public BewoningMetPeildatumQueryValidator()
    {
        RuleFor(x => x.AdresseerbaarObjectIdentificatie)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(AdresseerbaarObjectIdentificatiePattern).WithMessage(AdresseerbaarObjectIdentificatieErrorMessage)
            ;

        RuleFor(x => x.Peildatum)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .Custom((peildatum, context) =>
            {
                if(!peildatum.IsDateTime())
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;
    }
}
