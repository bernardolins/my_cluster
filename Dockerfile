ARG ELIXIR_VERSION=latest
ARG APP_TAG=master

FROM elixir:${ELIXIR_VERSION}

RUN mix local.hex --force
RUN mix local.rebar --force

RUN git clone https://github.com/bernardolins/my_cluster.git
WORKDIR my_cluster
RUN git checkout ${APP_TAG}

RUN mix deps.get
RUN mix compile

ENV POD_IP 127.0.0.1
ENV REPLACE_OS_VARS true

ENV MIX_ENV prod
RUN mix release --env=prod

ENV PORT 4000
ENTRYPOINT ["_build/prod/rel/my_cluster/bin/my_cluster", "foreground"]
