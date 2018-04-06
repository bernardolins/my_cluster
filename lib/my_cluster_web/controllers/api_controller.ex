defmodule MyClusterWeb.ApiController do
  use MyClusterWeb, :controller
  require Logger

  def info(conn, _params) do
    {:ok, host} = :inet.gethostname

    json conn, %{
      name: "MyCluster",
      host: to_string(host),
      node: Node.self(),
      node_list: Node.list
    }
  end

  def join_room(conn, params) do
    member = params["nickname"]
    room = params["room"] |> String.to_atom

    Logger.info "user is joining a new room: #{inspect params}"

    if Swarm.whereis_name(room) == :undefined do
      Logger.info "Creating a new room: #{inspect params}"
      Swarm.register_name(room, ChatRoom, :start_link, [])
    end
    Logger.info "Cast message to add a new member on room: #{room}"
    GenServer.cast({:via, :swarm, room}, {:add_member, member})

    Logger.info "Listing all members of room #{room}"
    {node_room, member_list} = GenServer.call({:via, :swarm, room}, :list_members)

    Logger.info "Replying!"
    json conn, %{
      member_list: member_list,
      room_node: node_room,
      request_node: Node.self()
    }
  end
end
