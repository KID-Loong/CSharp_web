# ----------------------------------------------------------------------------------------------------------------------
# Dotnet SDK build environment
# ----------------------------------------------------------------------------------------------------------------------
FROM microsoft/dotnet:2.0-sdk AS dotnet-build-env
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
FROM microsoft/dotnet:2.0.0-runtime
WORKDIR /usr/dist

# Copy compiled sources from builder image
COPY --from=dotnet-build-env /usr/dist .

# Copy settings and entrypoint
ADD ./Docker/entrypoint.sh .
ADD ./Source/appsettings.json .

ENTRYPOINT ["./entrypoint.sh"]