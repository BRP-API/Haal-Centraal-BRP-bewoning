using Bewoning.Validatie;
using HaalCentraal.BewoningProxy.Generated;
using Newtonsoft.Json.Linq;

namespace BewoningProxy.Validators;

public static class BewoningenQueryValidator
{
    public static ValidationResult Validate(this BewoningenQuery? bewoningenQuery, string requestBody)
    {
        var result = bewoningenQuery switch
        {
            BewoningMetPeildatum query => new BewoningMetPeildatumValidator().Validate(query),
            _ => new BewoningenQueryRequestBodyValidator().Validate(JObject.Parse(requestBody)),
        };

        return ValidationResult.CreateFrom(result);
    }
}
