namespace HaalCentraal.BewoningProxy.Generated;

[System.CodeDom.Compiler.GeneratedCode("NJsonSchema", "13.19.0.0 (NJsonSchema v10.9.0.0 (Newtonsoft.Json v13.0.0.0))")]
public partial class BewoningMetPeriode : BewoningenQuery
{
    [Newtonsoft.Json.JsonProperty("datumVan", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? DatumVan { get; set; }

    [Newtonsoft.Json.JsonProperty("datumTot", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? DatumTot { get; set; }

    [Newtonsoft.Json.JsonProperty("adresseerbaarObjectIdentificatie", Required = Newtonsoft.Json.Required.DisallowNull, NullValueHandling = Newtonsoft.Json.NullValueHandling.Ignore)]
    public string? AdresseerbaarObjectIdentificatie { get; set; }

}
