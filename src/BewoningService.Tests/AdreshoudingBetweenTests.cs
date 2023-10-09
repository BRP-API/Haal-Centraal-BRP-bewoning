using FluentAssertions;
using HaalCentraal.BewoningService.Controllers;
using HaalCentraal.BewoningService.Entities;

namespace BewoningService.Tests;

public class AdreshoudingBetweenTests
{
    [Fact]
    public void Persoon_met_datum_aanvang_in_periode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150808",
            DatumEindeAdreshouding = "20160101"
        }.AdreshoudingDatumsBetween(20150101, 20160101).Should().BeEquivalentTo(new[] { 20150808 });
    }

    [Fact]
    public void Persoon_met_datum_einde_in_periode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150101",
            DatumEindeAdreshouding = "20150808"
        }.AdreshoudingDatumsBetween(20150101, 20160101).Should().BeEquivalentTo(new[] { 20150808 });
    }

    [Fact]
    public void Persoon_met_datum_aanvang_en_einde_in_periode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150404",
            DatumEindeAdreshouding = "20150808"
        }.AdreshoudingDatumsBetween(20150101, 20160101).Should().BeEquivalentTo(new[] { 20150404, 20150808 });
    }

    [Fact]
    public void Persoon_met_datum_aanvang_en_einde_niet_in_periode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20140101",
            DatumEindeAdreshouding = "20150101"
        }.AdreshoudingDatumsBetween(20150101, 20160101).Should().BeEquivalentTo(Array.Empty<long>());
    }

    [Fact]
    public void Persoon_met_dag_onbekend_datum_aanvang_in_periode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150800",
            DatumEindeAdreshouding = "20160101"
        }.AdreshoudingDatumsBetween(20150101, 20160101).Should().BeEquivalentTo(new[] { 20150801, 20150901 });
    }

    [Theory]
    [InlineData(20150101, 20150808, 20150801)]
    [InlineData(20150808, 20160101, 20150901)]
    public void Persoon_met_dag_onbekend_datum_aanvang_overlapt_periode(long van, long tot, long expected)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150800",
            DatumEindeAdreshouding = "20160101"
        }.AdreshoudingDatumsBetween(van, tot).Should().BeEquivalentTo(new[] { expected });
    }

    [Fact]
    public void Persoon_met_dag_onbekend_datum_einde_in_periode()
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150101",
            DatumEindeAdreshouding = "20150800"
        }.AdreshoudingDatumsBetween(20150101, 20160101).Should().BeEquivalentTo(new[] { 20150801, 20150901 });
    }

    [Theory]
    [InlineData(20150101, 20150808, 20150801)]
    [InlineData(20150808, 20160101, 20150901)]
    public void Persoon_met_dag_onbekend_datum_einde_overlapt_periode(long van, long tot, long expected)
    {
        new Verblijfplaats
        {
            DatumAanvangAdreshouding = "20150101",
            DatumEindeAdreshouding = "20150800"
        }.AdreshoudingDatumsBetween(van, tot).Should().BeEquivalentTo(new[] { expected });
    }
}
