defmodule MyClusterWeb.ApiController do
  use MyClusterWeb, :controller

  def info(conn, _params) do
    {:ok, host} = :inet.gethostname

    json conn, %{
      name: "MyCluster",
      host: to_string(host),
      node: Node.self()
      node_list: Node.list,
    }
  end
end
