using FluentAssertions;
using HaalCentraal.BewoningService.Repositories;

namespace BewoningService.Tests;

public class ToGbaDatumTests
{
    [Theory]
    [InlineData("20200100", 20200101, 20200201)]
    [InlineData("20200200", 20200201, 20200301)]
    [InlineData("20200400", 20200401, 20200501)]
    public void JaarMaandDatum_wordt_eerste_dag_maand_en_eerste_dag_volgende_maand(string gbaDatum, long startDatum, long eindDatum)
    {
        gbaDatum.ToGbaDatum().Should().BeEquivalentTo(new [] {startDatum, eindDatum });
    }

    [Fact]
    public void JaarDatum_wordt_eerste_dag_jaar_en_eerste_dag_volgend_jaar()
    {
        "20200000".ToGbaDatum().Should().BeEquivalentTo(new [] { 20200101, 20210101 });
    }

    [Fact]
    public void Datum_wordt_datum()
    {
        "20200102".ToGbaDatum().Should().BeEquivalentTo(new [] { 20200102 });
    }

    [Fact]
    public void OnbekendDatum_wordt_geen_datum()
    {
        "00000000".ToGbaDatum().Should().BeEquivalentTo(Array.Empty<long>());
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData(" ")]
    [InlineData("abc")]
    [InlineData("20220230")]
    public void Ongeldige_datum_wordt_geen_datum(string gbaDatum)
    {
        gbaDatum.ToGbaDatum().Should().BeEquivalentTo(Array.Empty<long>());
    }
}
