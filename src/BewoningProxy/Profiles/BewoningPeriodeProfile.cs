using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;

public class BewoningPeriodeProfile : Profile
{
    public BewoningPeriodeProfile()
    {
        CreateMap<Gba.GbaBewoningPeriode, HC.BewoningPeriode>();
    }
}
