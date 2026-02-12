# Build stage
FROM elixir:1.15.7-otp-26 AS build

RUN apt-get update -y && apt-get install -y build-essential git && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ENV MIX_ENV=prod

COPY mix.exs mix.lock ./
COPY config config

RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get --only prod
RUN mix deps.compile

COPY priv priv
COPY lib lib
COPY assets assets
COPY rel rel

RUN mix assets.deploy
RUN mix compile
RUN mix release

# Runtime stage
FROM debian:bullseye-slim AS app

RUN apt-get update -y && apt-get install -y libstdc++6 openssl ca-certificates && rm -rf /var/lib/apt/lists/*

ENV MIX_ENV=prod

WORKDIR /app

COPY --from=build /app/_build/prod/rel/scripness ./

ENV PHX_SERVER=true
ENV PORT=8080

CMD ["/app/bin/server"]
