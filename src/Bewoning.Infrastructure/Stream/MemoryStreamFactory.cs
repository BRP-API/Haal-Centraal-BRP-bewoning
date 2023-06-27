using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bewoning.Infrastructure.Stream;

public static class MemoryStreamFactory
{
    public static MemoryStream ToMemoryStream(this string data, bool gzipCompress)
    {
        MemoryStream retval = new();

        StreamWriter streamWriter = gzipCompress
            ? new StreamWriter(new GZipStream(retval, CompressionMode.Compress))
            : new StreamWriter(retval);

        streamWriter.Write(data);
        streamWriter.Flush();

        retval.Seek(0, SeekOrigin.Begin);

        return retval;
    }
}
