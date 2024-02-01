using FluentAssertions;
using HaalCentraal.BewoningService.Controllers;

namespace BewoningService.Tests;

public class BetweenTests
{
    [Theory]
    [InlineData(20150808)]
    [InlineData(20150102)]
    [InlineData(20151231)]
    public void GbaDatum_valt_in_opgegeven_periode(long gbaDatum)
    {
        gbaDatum.Between(20150101, 20160101).Should().BeTrue();
    }

    [Theory]
    [InlineData(20140808)]
    [InlineData(20150101)]
    [InlineData(20160101)]
    public void GbaDatum_valt_niet_in_opgegeven_periode(long gbaDatum)
    {
        gbaDatum.Between(20150101, 20160101).Should().BeFalse();
    }
}
