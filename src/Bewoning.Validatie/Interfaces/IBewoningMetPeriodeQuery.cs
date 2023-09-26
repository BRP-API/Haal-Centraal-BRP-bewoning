namespace Bewoning.Validatie.Interfaces;

public interface IBewoningMetPeriodeQuery
{
    string? AdresseerbaarObjectIdentificatie { get; }
    string? DatumVan { get; }
    string? DatumTot { get; }
}
