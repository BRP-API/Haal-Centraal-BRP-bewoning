using Elastic.Apm.SerilogEnricher;
using Elastic.CommonSchema.Serilog;
using Microsoft.Extensions.Hosting;
using Serilog;
using Serilog.Enrichers.Span;
using Serilog.Exceptions;
using Serilog.Sinks.SystemConsole.Themes;

namespace Bewoning.Infrastructure.Logging;

public static class SerilogHelpers
{
    public static Action<HostBuilderContext, LoggerConfiguration> Configure()
    {
        return (context, config) =>
        {
            config
                .ReadFrom.Configuration(context.Configuration)
                .Enrich.WithElasticApmCorrelationInfo()
                .Enrich.WithExceptionDetails()
                .Enrich.WithMachineName()
                .Enrich.WithProperty("AppVersion", VersionHelpers.AppVersion)
                .Enrich.WithProperty("ApiVersion", VersionHelpers.ApiVersion)
                .Enrich.FromLogContext()
                .Enrich.With<ActivityEnricher>()
                .WriteTo.Console(outputTemplate: "[{Timestamp:HH:mm:ss} {Level}] {SourceContext}{NewLine}{Message:lj}{NewLine}{Exception}{NewLine}",
                                 theme: AnsiConsoleTheme.Code)
                .WriteTo.File(new EcsTextFormatter(), context.Configuration["Ecs:Path"]!)
                .WriteTo.Seq(context.Configuration["Seq:ServerUrl"]!);
        };
    }
}
