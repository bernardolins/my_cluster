FROM elixir:1.6.4

RUN mix local.hex --force
RUN mix local.rebar --force

EXPOSE 8080

COPY ./ /my_cluster
WORKDIR /my_cluster

RUN mix deps.get
RUN mix compile

ENTRYPOINT ["mix", "phx.server"]
