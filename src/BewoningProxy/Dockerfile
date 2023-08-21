#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/BewoningProxy/BewoningProxy.csproj", "src/BewoningProxy/"]
COPY ["src/Bewoning.Infrastructure/Bewoning.Infrastructure.csproj", "src/Bewoning.Infrastructure/"]
COPY ["src/Bewoning.Validatie/Bewoning.Validatie.csproj", "src/Bewoning.Validatie/"]
RUN dotnet restore "src/BewoningProxy/BewoningProxy.csproj"
COPY . .
WORKDIR "/src/src/BewoningProxy"
RUN dotnet build "BewoningProxy.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BewoningProxy.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BewoningProxy.dll"]