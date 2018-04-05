use Mix.Config
config :my_cluster, MyClusterWeb.Endpoint,
  load_from_system_env: true,
  url: [host: "my_cluster.com", port: 80],
  server: true,
  root: ".",
  version: Application.spec(:phoenix_distillery, :vsn)

config :libcluster,
  topologies: [
    k8s_example: [
      strategy: Cluster.Strategy.Kubernetes,
      config: [
        kubernetes_selector: "app=mycluster",
        kubernetes_node_basename: "my_cluster"
      ]
    ]
  ]

config :logger, level: :warn
