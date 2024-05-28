# Usa la imagen oficial de .NET Core como base
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copia el archivo csproj y restaura las dependencias
COPY src/ConsoleAppHelloWorld/ConsoleAppHelloWorld.csproj ./src/ConsoleAppHelloWorld/
RUN dotnet restore ./src/ConsoleAppHelloWorld/ConsoleAppHelloWorld.csproj

# Copia todo el contenido y construye la aplicación
COPY . .
RUN dotnet publish -c Release -o out ./src/ConsoleAppHelloWorld/ConsoleAppHelloWorld.csproj

# Genera una imagen ligera con el resultado de la compilación
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "ConsoleAppHelloWorld.dll"]
