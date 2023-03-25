FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
USER 10014
WORKDIR /src
COPY weatherservice.csproj .
RUN export DOTNET_CLI_HOME="/tmp/DOTNET_CLI_HOME"
RUN dotnet restore
COPY . .
RUN dotnet publish -c release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["dotnet", "weatherservice.dll"]