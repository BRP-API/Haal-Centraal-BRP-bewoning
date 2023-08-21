using HaalCentraal.BewoningService.Generated;
using HaalCentraal.BewoningService.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.BewoningService.Controllers;

[ApiController]
public class BewoningController : Generated.ControllerBase
{
    private readonly ILogger<BewoningController> _logger;
    private readonly PersoonRepository _repository;

    public BewoningController(ILogger<BewoningController> logger, PersoonRepository repository)
    {
        _logger = logger;
        _repository = repository;
    }

    public override async Task<ActionResult<GbaBewoningenQueryResponse>> Bewoningen([FromBody] BewoningenQuery body)
    {
        _logger.LogDebug("Request. {headers} {@body}", HttpContext.Request.Headers, body);

        var retval = body switch
        {
            BewoningMetPeildatum q => await Handle(q),
            _ => new GbaBewoningenQueryResponse()
        };

        _logger.LogDebug("Response. {@body}", retval);
        
        return Ok(retval);
    }

    private async Task<GbaBewoningenQueryResponse> Handle(BewoningMetPeildatum q)
    {
        var personen = await _repository.Zoek<BewoningMetPeildatum>(q);

        var retval = new GbaBewoningenQueryResponse
        {
            Bewoningen = new List<GbaBewoning>()
        };

        if (personen != null && personen.Any())
        {
            var bewoners = new List<GbaBewoner>();

            foreach (var persoon in personen)
            {
                var bewoner = new GbaBewoner
                {
                    Burgerservicenummer = persoon.BurgerserviceNummer,
                    GeheimhoudingPersoonsgegevens = persoon.GeheimhoudingPersoonsgegevens.GetValueOrDefault(0)
                };
                if(persoon.Verblijfplaats?.InOnderzoek != null)
                {
                    bewoner.VerblijfplaatsInOnderzoek = new GbaInOnderzoek
                    {
                        AanduidingGegevensInOnderzoek = persoon.Verblijfplaats.InOnderzoek.AanduidingGegevensInOnderzoek,
                        DatumIngangOnderzoek = persoon.Verblijfplaats.InOnderzoek.DatumIngangOnderzoek
                    };
                }

                bewoners.Add(bewoner);

                retval.Bewoningen.Add(new GbaBewoning
                {
                    AdresseerbaarObjectIdentificatie = q.AdresseerbaarObjectIdentificatie,
                    Periode = new Periode
                    {
                        DatumVan = q.Peildatum,
                        DatumTot = q.Peildatum.AddDays(1),
                    },
                    Bewoners = bewoners,
                });
            }
        }

        return retval;
    }
}
