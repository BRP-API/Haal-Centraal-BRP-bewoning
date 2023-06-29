using AutoMapper;
using Bewoning.Infrastructure.Json;
using HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;
using Newtonsoft.Json;

namespace BewoningProxy.Helpers;

public static class TransformHelpers
{
    public static string Transform(this string payload, IMapper mapper)
    {
        var response = JsonConvert.DeserializeObject<Gba.GbaBewoningenQueryResponse>(payload);

        return mapper.Map<BewoningenQueryResponse>(response)
                     .ToJsonWithoutNullAndDefaultValues();
    }
}
