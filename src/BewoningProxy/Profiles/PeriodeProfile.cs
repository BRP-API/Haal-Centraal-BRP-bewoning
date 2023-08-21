using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;

public class PeriodeProfile : Profile
{
    public PeriodeProfile()
    {
        CreateMap<Gba.Periode, HC.Periode>();
    }
}
