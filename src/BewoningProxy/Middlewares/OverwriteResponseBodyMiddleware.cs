using AutoMapper;
using Bewoning.Infrastructure.Http;
using Bewoning.Infrastructure.ProblemJson;
using Bewoning.Infrastructure.Stream;
using BewoningProxy.Helpers;
using BewoningProxy.Validators;
using HaalCentraal.BewoningProxy.Generated;
using Newtonsoft.Json;

namespace BewoningProxy.Middlewares;

public class OverwriteResponseBodyMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<OverwriteResponseBodyMiddleware> _logger;
    private readonly IMapper _mapper;

    public OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper)
    {
        _next = next;
        _logger = logger;
        _mapper = mapper;
    }

    private async Task<bool> RequestIsValid(HttpContext context, string requestBody, Stream orgBodyStream)
    {
        if (!await context.MethodIsAllowed(orgBodyStream))
        {
            _logger.LogWarning("method not allowed: {@request.method}", context.Request.Method);
            return false;
        }
        if (!await context.AcceptIsAllowed(orgBodyStream))
        {
            _logger.LogWarning("Not supported Accept value: {@request.header}", context.Request.Headers.Accept);
            return false;
        }
        if (!await context.ContentTypeIsAllowed(orgBodyStream))
        {
            _logger.LogWarning("Not supported Content-Type value: {@request.header}", context.Request.Headers.ContentType);
            return false;
        }

        BewoningenQuery? bewoningenQuery = JsonConvert.DeserializeObject<BewoningenQuery>(requestBody);

        var validationResult = bewoningenQuery.Validate(requestBody);
        if (!validationResult.IsValid)
        {
            await context.HandleValidationErrors(validationResult, orgBodyStream);
            return false;
        }

        return true;
    }

    public async Task Invoke(HttpContext context)
    {
        _logger.LogDebug("TimeZone: {@localTimeZone}. Now: {@now}", TimeZoneInfo.Local.StandardName, DateTime.Now);

        var orgBodyStream = context.Response.Body;
        string requestBody = string.Empty;
        try
        {
            requestBody = await context.Request.ReadBodyAsync();

            _logger.LogDebug("request headers: {@requestHeaders}", context.Request.Headers);
            _logger.LogDebug("request body: {@request.body}", requestBody);

            if (!await RequestIsValid(context, requestBody, orgBodyStream))
            {
                return;
            }

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await _next(context);

            var body = await context.Response.ReadBodyAsync();

            _logger.LogDebug("original response body: {response.body}", body);

            var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                ? body.Transform(_mapper)
                : body;

            _logger.LogDebug("transformed response body: {response.body}", modifiedBody);

            using var bodyStream = modifiedBody.ToMemoryStream(context.Response.UseGzip());

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "request body: {@request.body} headers: {@request.headers}", requestBody, context.Request.Headers);
            await context.HandleUnhandledException(orgBodyStream);
        }
    }
}
