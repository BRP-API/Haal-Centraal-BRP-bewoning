using AutoMapper;
using Bewoning.Infrastructure.Json;
using HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;
using Newtonsoft.Json;

namespace BewoningProxy.Helpers;

public static class TransformHelpers
{
    private static bool IsProxyResponse(this string payload){
        var proxyTokens = new List<string>
        {
            "\"inOnderzoek\":",
            "\"geheimhoudingPersoonsgegevens\":true",
        };

        return proxyTokens.Exists(t => payload.Contains(t));
    }

    public static string Transform(this string payload, IMapper mapper, ILogger logger)
    {
        if(payload.IsProxyResponse())
        {
            logger.LogInformation("proxy2proxy");
            return payload;
        }

        var response = JsonConvert.DeserializeObject<Gba.GbaBewoningenQueryResponse>(payload);

        return mapper.Map<BewoningenQueryResponse>(response)
                     .ToJsonWithoutNullAndDefaultValues();
    }
}
