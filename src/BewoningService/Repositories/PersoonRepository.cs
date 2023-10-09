using HaalCentraal.BewoningService.Entities;
using HaalCentraal.BewoningService.Generated;
using Newtonsoft.Json;

namespace HaalCentraal.BewoningService.Repositories;

public class PersoonRepository
{
    private readonly IWebHostEnvironment _environment;

    public PersoonRepository(IWebHostEnvironment environment)
    {
        _environment = environment;
    }

    public async Task<ICollection<Persoon>?> Zoek<T>(T query)
    {
        var path = Path.Combine(_environment.ContentRootPath, "Data", "test-data.json");
        if (!File.Exists(path))
        {
            throw new FileNotFoundException($"invalid file: '{path}'");
        }

        var data = await File.ReadAllTextAsync(path);

        return query switch
        {
            BewoningMetPeildatum f => JsonConvert.DeserializeObject<List<Persoon>>(data)?
                .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList(),
            BewoningMetPeriode f => JsonConvert.DeserializeObject<List<Persoon>>(data)?
                .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList(),
            _ => throw new NotSupportedException($"{query}")
        };
    }
}
