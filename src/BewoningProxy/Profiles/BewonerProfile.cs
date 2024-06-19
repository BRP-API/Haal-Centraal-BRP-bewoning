using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;

public class BewonerProfile : Profile
{
    public BewonerProfile()
    {
        CreateMap<Gba.GbaBewoner, HC.Bewoner>()
            .ForMember(dest => dest.InOnderzoek, opt => 
            {
                opt.PreCondition(src => src.VerblijfplaatsInOnderzoek != null);
                opt.MapFrom(src => src.VerblijfplaatsInOnderzoek.AanduidingGegevensInOnderzoek.Map());
            })
            ;
    }
}

public static class VerblijfplaatsInOnderzoekConverter
{
    public static bool Map(this string inOnderzoek)
    {
        return inOnderzoek switch
        {
            "080000" or
            "081000" or
            "081010" or
            "081030" or
            "081100" or
            "081180" or
            "580000" or
            "581000" or
            "581010" or
            "581030" or
            "581100" or
            "581180" => true,
            _ => false
        };
    }
}
