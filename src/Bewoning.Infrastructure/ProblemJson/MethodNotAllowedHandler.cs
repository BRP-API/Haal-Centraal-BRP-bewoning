﻿using Bewoning.Infrastructure.Http;
using Bewoning.Infrastructure.Json;
using Bewoning.Infrastructure.Stream;
using Microsoft.AspNetCore.Http;

namespace Bewoning.Infrastructure.ProblemJson;

public static class MethodNotAllowedHandler
{
    private static Foutbericht CreateMethodNotAllowedFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Status = StatusCodes.Status405MethodNotAllowed,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Method not allowed.",
            Type = new Uri(StatusCodeIdentifiers.MethodNotAllowedIdentifier)
        };
    }

    public static async Task<bool> MethodIsAllowed(this HttpContext context, System.IO.Stream orgResponseBodyStream)
    {
        if (context.Request.Method == HttpMethod.Post.Method) return true;

        var foutbericht = context.CreateMethodNotAllowedFoutbericht();

        using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetHeaderPropertiesFrom(foutbericht, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);

        return false;
    }
}