namespace HaalCentraal.BewoningService.Repositories;

public static class GbaDatumHelpers
{
    public static long ToNumber(this string gbaDatum) => long.Parse(gbaDatum);

    public static long ToNumber(this DateTimeOffset datum) => datum.ToString("yyyyMMdd").ToNumber(); 
}