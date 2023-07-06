using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;


public class BewoningenQueryResponseProfile : Profile
{
    public BewoningenQueryResponseProfile()
    {
        CreateMap<Gba.GbaAbstractBewoning, HC.AbstractBewoning>().ConvertUsing<BewoningConverter>();

        CreateMap<Gba.GbaBewoningenQueryResponse, HC.BewoningenQueryResponse>();
    }
}
