using FluentValidation;
using Newtonsoft.Json.Linq;

namespace BewoningProxy.Validators;

public class BewoningenQueryRequestBodyValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "type||required||Parameter is verplicht.";
    const string TypePattern = @"^BewoningMetPeildatum|BewoningMetPeriode$";
    const string TypePatternErrorMessage = "type||value||Waarde is geen geldig zoek type.";

    public BewoningenQueryRequestBodyValidator()
    {
        RuleFor(x => x.Value<string>("type"))
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(TypePattern).WithMessage(TypePatternErrorMessage);
    }
}