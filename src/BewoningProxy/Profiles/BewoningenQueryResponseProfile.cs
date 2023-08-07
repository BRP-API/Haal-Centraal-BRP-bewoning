using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;


public class BewoningenQueryResponseProfile : Profile
{
    public BewoningenQueryResponseProfile()
    {
        CreateMap<Gba.GbaBewoning, HC.Bewoning>();

        CreateMap<Gba.GbaBewoningenQueryResponse, HC.BewoningenQueryResponse>();
    }
}
