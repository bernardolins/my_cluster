defmodule MyClusterWeb.ApiController do
  use MyClusterWeb, :controller

  def info(conn, _params) do
    {:ok, host} = :inet.gethostname

    json conn, %{
      name: "MyCluster",
      host: to_string(host),
      nodes: Node.list,
    }
  end
end
