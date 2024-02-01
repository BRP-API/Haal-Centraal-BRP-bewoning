using FluentAssertions;
using HaalCentraal.BewoningService.Controllers;
using HaalCentraal.BewoningService.Entities;
using HaalCentraal.BewoningService.Generated;
using HaalCentraal.BewoningService.Repositories;

namespace BewoningService.Tests;

public class IsMogelijkeBewonerTests
{
    [Fact]
    public void adreshouding_periode_heeft_geen_onzekerheidsperiode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150808"
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = 20150808.ToDateTimeOffset(),
            DatumTot = 20150901.ToDateTimeOffset()
        }).Should().BeFalse();
    }

    [Theory]
    [InlineData("20150800", 20150701, 20150801)]
    [InlineData("20150000", 20141201, 20150101)]
    public void opgegeven_periode_ligt_vóór_onzekerheidsperiode_aanvang(string datumAanvang, long van, long tot)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = datumAanvang
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = van.ToDateTimeOffset(),
            DatumTot = tot.ToDateTimeOffset()
        }).Should().BeFalse();
    }

    [Theory]
    [InlineData("20150700", 20150801, 20150901)]
    [InlineData("20150000", 20160101, 20160201)]
    public void opgegeven_periode_ligt_na_onzekerheidsperiode_einde(string datumEinde, long van, long tot)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "00000000",
            DatumEindeAdreshouding = datumEinde
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = van.ToDateTimeOffset(),
            DatumTot = tot.ToDateTimeOffset()
        }).Should().BeFalse();
    }

    [Theory]
    [InlineData("20150400", "20150600")]
    [InlineData("20140000", "20160000")]
    public void opgegeven_periode_ligt_tussen_onzekerheidsperiode_aanvang_en_onzekerheidsperiode_einde(string datumAanvang, string datumEinde)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = datumAanvang,
            DatumEindeAdreshouding = datumEinde
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = 20150501.ToDateTimeOffset(),
            DatumTot = 20150601.ToDateTimeOffset()
        }).Should().BeFalse();
    }

    [Theory]
    [InlineData("20150800")]
    [InlineData("20150000")]
    [InlineData("00000000")]
    public void opgegeven_periode_ligt_in_onzekerheidsperiode_aanvang(string datumAanvang)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = datumAanvang
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = 20150801.ToDateTimeOffset(),
            DatumTot = 20150901.ToDateTimeOffset()
        }).Should().BeTrue();
    }

    [Theory]
    [InlineData("20150800")]
    [InlineData("20150000")]
    [InlineData("00000000")]
    public void opgegeven_periode_ligt_in_onzekerheidsperiode_einde(string datumEinde)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20140101",
            DatumEindeAdreshouding = datumEinde
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = 20150801.ToDateTimeOffset(),
            DatumTot = 20150901.ToDateTimeOffset()
        }).Should().BeTrue();
    }

    [Fact]
    public void aanvang_en_einde_adreshouding_zijn_geheel_onzeker()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "00000000",
            DatumEindeAdreshouding = "00000000"
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = 20150801.ToDateTimeOffset(),
            DatumTot = 20150901.ToDateTimeOffset()
        }).Should().BeTrue();
    }

    [Theory]
    [InlineData("00000000", "20150700", 20150701, 20150801)]
    [InlineData("00000000", "20150700", 20150601, 20150701)]
    [InlineData("00000000", "20150000", 20151201, 20160101)]
    [InlineData("20150000", "20150700", 20150101, 20150701)]
    public void opgegeven_periode_ligt_in_overlappende_onzekerheidsperiodes(string datumAanvang, string datumEinde, long van, long tot)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = datumAanvang,
            DatumEindeAdreshouding = datumEinde
        }.IsMogelijkeBewoner(new Periode
        {
            DatumVan = van.ToDateTimeOffset(),
            DatumTot = tot.ToDateTimeOffset()
        }).Should().BeTrue();
    }
}
