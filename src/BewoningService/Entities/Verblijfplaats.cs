namespace HaalCentraal.BewoningService.Entities;

public class Verblijfplaats
{
    public string? AdresseerbaarObjectIdentificatie { get; set; }
    public string? DatumAanvangAdreshouding { get; set; }
    public string? DatumEindeAdreshouding { get; set; }
    public VerblijfplaatsInOnderzoek? InOnderzoek { get; set; }
}

public class VerblijfplaatsInOnderzoek
{
    public string? AanduidingGegevensInOnderzoek { get; set; }
    public string? DatumIngangOnderzoek { get; set; }
}