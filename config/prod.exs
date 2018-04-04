use Mix.Config
config :my_cluster, MyClusterWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "my_cluster.com", port: 80],
  server: true,
  root: ".",
  version: Application.spec(:phoenix_distillery, :vsn)

config :logger, level: :warn
