using FluentAssertions;
using HaalCentraal.BewoningService.Controllers;
using HaalCentraal.BewoningService.Generated;
using HaalCentraal.BewoningService.Repositories;

namespace BewoningService.Tests;

public class ToBewoningMetPeriodeTests
{
    [Fact]
    public void gevraagde_periode_wordt_gesplitst()
    {
        new List<long> { 20150101, 20150808, 20160101 }.ToBewoningenMetPeriode("0599010000208579")
            .Should().BeEquivalentTo(new List<GbaBewoning>
            {
                new()
                {
                    AdresseerbaarObjectIdentificatie = "0599010000208579",
                    Periode = new Periode
                    {
                        DatumVan = 20150101.ToDateTimeOffset(),
                        DatumTot = 20150808.ToDateTimeOffset()
                    },
                    Bewoners = new List<GbaBewoner>(),
                    MogelijkeBewoners = new List<GbaBewoner>()
                },
                new()
                {
                    AdresseerbaarObjectIdentificatie = "0599010000208579",
                    Periode = new Periode
                    {
                        DatumVan = 20150808.ToDateTimeOffset(),
                        DatumTot = 20160101.ToDateTimeOffset()
                    },
                    Bewoners = new List<GbaBewoner>(),
                    MogelijkeBewoners = new List<GbaBewoner>()
                },
            });
    }

    [Fact]
    public void gevraagde_periode_wordt_niet_gesplitst()
    {
        new List<long> { 20150101, 20160101 }.ToBewoningenMetPeriode("0599010000208579")
            .Should().BeEquivalentTo(new List<GbaBewoning>
            {
                new()
                {
                    AdresseerbaarObjectIdentificatie = "0599010000208579",
                    Periode = new Periode
                    {
                        DatumVan = 20150101.ToDateTimeOffset(),
                        DatumTot = 20160101.ToDateTimeOffset()
                    },
                    Bewoners = new List<GbaBewoner>(),
                    MogelijkeBewoners = new List<GbaBewoner>()
                }
            });
    }
}
