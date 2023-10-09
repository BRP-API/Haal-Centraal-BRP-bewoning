namespace HaalCentraal.BewoningService.Generated;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.19.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class BewoningMetPeildatum : BewoningenQuery
{
    [Newtonsoft.Json.JsonProperty("peildatum", Required = Newtonsoft.Json.Required.Default, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? Peildatum { get; set; }

    [Newtonsoft.Json.JsonProperty("adresseerbaarObjectIdentificatie", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? AdresseerbaarObjectIdentificatie { get; set; }

}
