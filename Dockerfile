#sdk5.0 para poder utilizar comandos dotnet
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /source
COPY *.csproj /source
RUN dotnet restore
COPY . ./webapp
WORKDIR /source/webapp
#build para generar la ddl con el csproj
RUN dotnet build

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
#copiamos la dll al dir /app
#COPY --from=build C:\\source\\webapp\\bin\\Debug\\net5.0\\myWebApp.dll /app
#COPY --from=build C:\\source\\webapp\\bin\\Debug\\net5.0\\myWebApp.deps.json /app
#COPY --from=build C:\\source\\webapp\\bin\\Debug\\net5.0\\myWebApp.runtimeconfig.json /app
COPY --from=build C:\\source\\webapp\\bin\\Debug\\net5.0 /app
EXPOSE 5001
ENV ASPNETCORE_URLS=http://*:5001
ENTRYPOINT ["dotnet", "myWebApp.dll"]
