using Bewoning.Infrastructure.Logging;
using HaalCentraal.BewoningService.Repositories;
using Serilog;

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .CreateLogger();

try
{
    Log.Information("Starting Bewoning Mock");

    var builder = WebApplication.CreateBuilder(args);

    builder.Logging.ClearProviders();
    builder.Host.UseSerilog(SerilogHelpers.Configure());

    // Add services to the container.

    builder.Services.AddControllers()
                    //.ConfigureInvalidModelStateHandling()
                    .AddNewtonsoftJson();

    builder.Services.AddScoped<PersoonRepository>();

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    app.UseSerilogRequestLogging();

    app.MapControllers();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Bewoning Mock terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}
