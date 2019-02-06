FROM elixir:1.8.0

ENV MIX_ENV=dev

RUN apt-get update \
    && apt-get install -y postgresql-client-9.6

RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /opt/app
COPY . .

RUN rm -rf deps/* && \
    mix deps.get