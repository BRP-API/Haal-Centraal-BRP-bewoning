using AutoMapper;
using Bewoning.Infrastructure.Http;
using Bewoning.Infrastructure.ProblemJson;
using Bewoning.Infrastructure.Stream;
using BewoningProxy.Helpers;
using BewoningProxy.Validators;
using HaalCentraal.BewoningProxy.Generated;
using Newtonsoft.Json;
using Serilog;

namespace BewoningProxy.Middlewares;

public class OverwriteResponseBodyMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
    private readonly IMapper _mapper;
    private readonly IDiagnosticContext _diagnosticContext;

    public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper, IDiagnosticContext diagnosticContext)
    {
        _next = next;
        _logger = logger;
        _mapper = mapper;
        _diagnosticContext = diagnosticContext;
    }

    private async Task<bool> RequestIsValid(HttpContext context, string requestBody, Stream orgBodyStream)
    {
        var problemJson = await context.MethodIsAllowed(orgBodyStream);
        if (problemJson != null)
        {
            _diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }
        problemJson = await context.AcceptIsAllowed(orgBodyStream);
        if (problemJson != null)
        {
            _diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }
        problemJson = await context.ContentTypeIsAllowed(orgBodyStream);
        if (problemJson != null)
        {
            _diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }

        BewoningenQuery? bewoningenQuery;
        try
        {
            bewoningenQuery = JsonConvert.DeserializeObject<BewoningenQuery>(requestBody);
        }
        catch (JsonSerializationException ex)
        {
            problemJson = await context.HandleJsonDeserializeException(ex, orgBodyStream);
            _diagnosticContext.SetException(ex);
            _diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }
        catch (JsonReaderException ex)
        {
            problemJson = await context.HandleJsonDeserializeException(ex, orgBodyStream);
            _diagnosticContext.SetException(ex);
            _diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }

        var validationResult = bewoningenQuery.Validate(requestBody);
        if (!validationResult.IsValid)
        {
            problemJson = await context.HandleValidationErrors(validationResult, orgBodyStream);
            _diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }

        return true;
    }

    public async Task Invoke(HttpContext context)
    {
        _logger.LogDebug("TimeZone: {@localTimeZone}. Now: {@now}", TimeZoneInfo.Local.StandardName, DateTime.Now);

        var orgBodyStream = context.Response.Body;

        try
        {
            var requestBody = await context.Request.ReadBodyAsync();
            _diagnosticContext.Set("request.body", requestBody);
            _diagnosticContext.Set("request.headers", context.Request.Headers);

            if (!await RequestIsValid(context, requestBody, orgBodyStream))
            {
                return;
            }

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await _next(context);

            var body = await context.Response.ReadBodyAsync();

            _diagnosticContext.Set("api response.body", body);

            var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                ? body.Transform(_mapper, _logger)
                : body;

            _diagnosticContext.Set("response.body", modifiedBody);

            using var bodyStream = modifiedBody.ToMemoryStream(context.Response.UseGzip());

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
        catch (Exception ex)
        {
            var problemJson = await context.HandleUnhandledException(orgBodyStream);
            _diagnosticContext.SetException(ex);
            _diagnosticContext.Set("response.body", problemJson, true);
        }
    }
}
