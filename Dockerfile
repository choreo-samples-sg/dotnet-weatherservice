# FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build
FROM mcr.microsoft.com/dotnet/sdk:7.0-alpine AS build

# WORKDIR /src
WORKDIR /source

# COPY weatherservice.csproj .
COPY *.csproj .
RUN dotnet restore --use-current-runtime  


COPY . .
RUN dotnet publish -c release -o /app --use-current-runtime  
# RUN dotnet publish --use-current-runtime -c Release --self-contained false --no-restore -o /app


# FROM mcr.microsoft.com/dotnet/aspnet:7.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0-preview-alpine

ENV DOTNET_ROLL_FORWARD=Major
ENV DOTNET_ROLL_FORWARD_PRE_RELEASE=1

WORKDIR /app
COPY --from=build /app .

USER app

ENTRYPOINT ["dotnet", "weatherservice.dll"]