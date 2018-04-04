FROM elixir:1.6.4

RUN mix local.hex --force
RUN mix local.rebar --force

EXPOSE 8080

COPY ./ /my_cluster
WORKDIR /my_cluster

RUN mix deps.get
RUN mix compile

ENV MIX_ENV prod
RUN mix release --env=prod

ENV PORT 4000
ENTRYPOINT ["_build/prod/rel/my_cluster/bin/my_cluster", "foreground"]
