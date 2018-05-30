# ----------------------------------------------------------------------------------------------------------------------
# Dotnet SDK build environment
# ----------------------------------------------------------------------------------------------------------------------
#FROM microsoft/dotnet
FROM 127.0.0.1:5600/dotnet:hub
WORKDIR /usr/src

# Copy csproj and restore as distinct layers
COPY ./Source/*.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ./Source ./
RUN dotnet publish -c Release -o /usr/dist
RUN ls -la /usr/dist

# ----------------------------------------------------------------------------------------------------------------------
# Build runtime image
# ----------------------------------------------------------------------------------------------------------------------
WORKDIR /usr/dist

# Copy settings and entrypoint
ADD ./Docker/entrypoint.sh .
ADD ./Source/appsettings.json .

ENTRYPOINT ["./entrypoint.sh"]
