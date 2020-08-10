FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
WORKDIR /app
EXPOSE 5110

COPY ./package ./

ENTRYPOINT ["dotnet", "jenkins.dll"]
