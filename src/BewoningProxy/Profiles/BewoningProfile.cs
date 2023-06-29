using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;

public class BewoningProfile : Profile
{
    public BewoningProfile()
    {
        CreateMap<Gba.GbaBewoning, HC.Bewoning>();
    }
}
