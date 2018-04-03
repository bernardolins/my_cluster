# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :my_cluster, MyClusterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uT3T+cFs8zoTcm4Qs9YRwhvB2C6yLSWnf5IGzynsa2680hDmjdJAU1HGmbNakPFz",
  render_errors: [view: MyClusterWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: MyCluster.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :libcluster,
  topologies: [
    k8s_example: [
      strategy: Cluster.Strategy.Kubernetes,
      config: [
        kubernetes_selector: "app=mycluster",
        kubernetes_node_basename: "mycluster"
      ]
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"