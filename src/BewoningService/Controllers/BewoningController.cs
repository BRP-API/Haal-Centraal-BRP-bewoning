using HaalCentraal.BewoningService.Generated;
using Microsoft.AspNetCore.Mvc;

namespace HaalCentraal.BewoningService.Controllers;

[ApiController]
public class BewoningController : Generated.ControllerBase
{
    private readonly ILogger<BewoningController> _logger;

    public BewoningController(ILogger<BewoningController> logger)
    {
        _logger = logger;
    }

    public override async Task<ActionResult<GbaBewoningenQueryResponse>> Bewoningen([FromBody] BewoningenQuery body)
    {
        _logger.LogDebug("Request. {headers} {@body}", HttpContext.Request.Headers, body);

        var retval = body switch
        {
            _ => new GbaBewoningenQueryResponse()
        };

        _logger.LogDebug("Response. {@body}", retval);
        
        return Ok(retval);
    }
}
