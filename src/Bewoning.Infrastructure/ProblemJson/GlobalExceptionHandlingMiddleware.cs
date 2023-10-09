using Bewoning.Infrastructure.Http;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Serilog;

namespace Bewoning.Infrastructure.ProblemJson;

public class GlobalExceptionHandlingMiddleware
{

    private readonly RequestDelegate _next;
    private readonly IDiagnosticContext _diagnosticContext;

    public GlobalExceptionHandlingMiddleware(RequestDelegate next, IDiagnosticContext diagnosticContext)
    {
        _next = next;
        _diagnosticContext = diagnosticContext;
    }

    public async Task Invoke(HttpContext context)
    {
        try
        {
            if (!context.Request.Body.CanSeek)
            {
                context.Request.EnableBuffering();
            }

            await _next(context);
        }
        catch (Exception ex)
        {
            await HandleException(context, ex);
        }
    }

    private Task HandleException(HttpContext context, Exception ex)
    {
        var foutbericht = context.CreateInternalServerErrorFoutbericht();

        context.Response.StatusCode = foutbericht.Status!.Value;
        context.Response.ContentType = ContentTypes.ProblemJson;

        var requestBody = context.Request.ReadBodyAsync().Result;

        _diagnosticContext.Set("request.body", requestBody);
        _diagnosticContext.Set("request.headers", context.Request.Headers);
        _diagnosticContext.SetException(ex);
        _diagnosticContext.Set("response.body", foutbericht, true);

        return context.Response.WriteAsync(JsonConvert.SerializeObject(foutbericht, new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Ignore,
            DefaultValueHandling = DefaultValueHandling.Ignore
        }));
    }
}