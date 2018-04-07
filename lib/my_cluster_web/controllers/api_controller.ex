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

  def join_room(conn, params) do
    member_nickname = params["nickname"]
    room = params["room"]

    :ok = MyCluster.ChatRoom.add_member(room, member_nickname)

    send_resp(conn, 201, "")
  end

  def list_members(conn, params) do
    room = params["room"]
    {node_room, member_list} = MyCluster.ChatRoom.list_all_members(room)

    json conn, %{
      members: member_list,
      room_node: node_room,
      request_node: Node.self()
    }
  end
end
