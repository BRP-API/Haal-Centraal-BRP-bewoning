using Bewoning.Validatie.Interfaces;
using FluentValidation;

namespace Bewoning.Validatie.Validators;

public class BewoningMetPeriodeQueryValidator : AbstractValidator<IBewoningMetPeriodeQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string AdresseerbaarObjectIdentificatiePattern = @"^(?!0{16})[0-9]{16}$";
    const string AdresseerbaarObjectIdentificatieErrorMessage = $"pattern||Waarde voldoet niet aan patroon {AdresseerbaarObjectIdentificatiePattern}.";
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";
    const string DateGreaterThanErrorMessage = "invalidParam||datumTot moet na datumVan liggen.";
    public BewoningMetPeriodeQueryValidator()
    {
        RuleFor(x => x.AdresseerbaarObjectIdentificatie)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(AdresseerbaarObjectIdentificatiePattern).WithMessage(AdresseerbaarObjectIdentificatieErrorMessage)
            ;

        RuleFor(x => x.DatumTot)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .Custom((datumTot, context) =>
            {
                if (!datumTot.IsDateTime())
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;

        RuleFor(x => x.DatumVan)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .Custom((datumVan, context) =>
            {
                if (!datumVan.IsDateTime())
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;

        RuleFor(x => x.DatumTot!.ToDateTimeOffset())
            .GreaterThan(x => x.DatumVan!.ToDateTimeOffset()).WithMessage(DateGreaterThanErrorMessage).WithName("datumTot")
            .When(x => x.DatumTot.IsDateTime() && x.DatumVan.IsDateTime())
            ;
    }
}
