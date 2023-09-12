using Bewoning.Validatie.Interfaces;
using FluentValidation;
using System.Globalization;

namespace Bewoning.Validatie.Validators;

public class BewoningMetPeriodeQueryValidator : AbstractValidator<IBewoningMetPeriodeQuery>
{
    static readonly CultureInfo _nl = new("nl-NL");
    const string dateFormat = "yyyy-MM-dd";

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
                if (!DateTime.TryParseExact(datumTot, dateFormat, _nl.DateTimeFormat, DateTimeStyles.None, out _))
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
                if (!DateTime.TryParseExact(datumVan, dateFormat, _nl.DateTimeFormat, DateTimeStyles.None, out _))
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;

        RuleFor(x => DateTime.ParseExact(x.DatumTot!, dateFormat, _nl.DateTimeFormat, DateTimeStyles.None))
            .GreaterThan(x => DateTime.ParseExact(x.DatumVan!, dateFormat, _nl.DateTimeFormat, DateTimeStyles.None)).WithMessage(DateGreaterThanErrorMessage).WithName("datumTot")
            .When(x =>
                DateTime.TryParseExact(x.DatumTot, dateFormat, _nl.DateTimeFormat, DateTimeStyles.None, out _) &&
                DateTime.TryParseExact(x.DatumVan, dateFormat, _nl.DateTimeFormat, DateTimeStyles.None, out _))
            ;
    }
}
