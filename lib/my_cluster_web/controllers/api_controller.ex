defmodule MyClusterWeb.ApiController do
  use MyClusterWeb, :controller

  def info(conn, _params) do
    {:ok, host} = :inet.gethostname

    json conn, %{
      name: "MyCluster",
      host: to_string(host),
      node: Node.self(),
      node_list: Node.list
    }
  end

  def join_room(conn, _params) do
    member = _params["nickname"]
    room = _params["room"] |> String.to_atom

    if Swarm.whereis_name(room) == :undefined do
      IO.puts("HERE")
      Swarm.register_name(room, ChatRoom, :start_link, [])
    end
    GenServer.cast({:via, :swarm, room}, {:add_member, member})

    {node_room, member_list} = GenServer.call({:via, :swarm, room}, :list_members)

    json conn, %{
      member_list: member_list,
      room_node: node_room,
      request_node: Node.self()
    }
  end
end
