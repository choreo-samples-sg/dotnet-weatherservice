# FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

# WORKDIR /src
WORKDIR /source

# COPY weatherservice.csproj .
COPY *.csproj .
RUN dotnet restore


COPY . .
RUN dotnet publish -c release -o /app --no-restore
# RUN dotnet publish --use-current-runtime -c Release --self-contained false --no-restore -o /app


FROM mcr.microsoft.com/dotnet/aspnet:7.0
# FROM mcr.microsoft.com/dotnet/aspnet:8.0-preview-alpine
ENV ASPNETCORE_URLS=http://+:5000
ENV COMPlus_EnableDiagnostics=0
WORKDIR /app
COPY --from=build /app ./
EXPOSE 5000
USER 10015

ENTRYPOINT ["dotnet", "weatherservice.dll"]




