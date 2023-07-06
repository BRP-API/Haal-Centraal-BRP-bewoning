using AutoMapper;
using HC = HaalCentraal.BewoningProxy.Generated;
using Gba = HaalCentraal.BewoningProxy.Generated.Gba;

namespace BewoningProxy.Profiles;

public class BewoningConverter : ITypeConverter<Gba.GbaAbstractBewoning, HC.AbstractBewoning>
{
    public HC.AbstractBewoning Convert(Gba.GbaAbstractBewoning source, HC.AbstractBewoning destination, ResolutionContext context)
    {
        return source switch
        {
            Gba.GbaBewoning => context.Mapper.Map<HC.Bewoning>(source),
            _ => throw new NotSupportedException()
        };
    }
}
