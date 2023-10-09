using Bewoning.Validatie;
using HaalCentraal.BewoningService.Generated;
using HaalCentraal.BewoningService.Repositories;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace HaalCentraal.BewoningService.Controllers;

[ApiController]
public class BewoningController : Generated.ControllerBase
{
    private readonly IDiagnosticContext _diagnosticContext;
    private readonly PersoonRepository _repository;

    public BewoningController(IDiagnosticContext diagnosticContext, PersoonRepository repository)
    {
        _diagnosticContext = diagnosticContext;
        _repository = repository;
    }

    public override async Task<ActionResult<GbaBewoningenQueryResponse>> Bewoningen([FromBody] BewoningenQuery body)
    {
        _diagnosticContext.Set("request.body", body, true);
        _diagnosticContext.Set("request.headers", HttpContext.Request.Headers);

        var retval = body switch
        {
            BewoningMetPeildatum q => await Handle(q),
            BewoningMetPeriode q => await Handle(q),
            _ => new GbaBewoningenQueryResponse()
        };

        _diagnosticContext.Set("response.body", retval, true);
        
        return Ok(retval);
    }

    private async Task<GbaBewoningenQueryResponse> Handle(BewoningMetPeildatum q)
    {
        var personen = await _repository.Zoek<BewoningMetPeildatum>(q);

        return new GbaBewoningenQueryResponse
        {
            Bewoningen = personen.ToGbaBewoningen(q.AdresseerbaarObjectIdentificatie!,
                                                  q.Peildatum!,
                                                  q.Peildatum!.ToDateTimeOffset().AddDays(1).ToString("yyyy-MM-dd"))
        };
    }

    private async Task<GbaBewoningenQueryResponse> Handle(BewoningMetPeriode q)
    {
        var personen = await _repository.Zoek<BewoningMetPeriode>(q);
                                          

        return new GbaBewoningenQueryResponse
        {
            Bewoningen = personen.ToGbaBewoningen(q.AdresseerbaarObjectIdentificatie!, q.DatumVan!, q.DatumTot!)
        };
    }
}
