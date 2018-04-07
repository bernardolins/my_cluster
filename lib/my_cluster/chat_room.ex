defmodule MyCluster.ChatRoom do
  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    {:ok, state}
  end

  def add_member(room, member_nickname) do
    if Swarm.whereis_name(room) == :undefined do
      Swarm.register_name(room, __MODULE__, :start_link, [])
    end
    GenServer.cast({:via, :swarm, room}, {:add_member, member_nickname})
  end

  def list_all_members(room) do
    if Swarm.whereis_name(room) == :undefined do
      {Node.self(), []}
    else
      GenServer.call({:via, :swarm, room}, :list_members)
    end
  end

  def handle_cast({:add_member, member}, member_list) do
    {:noreply, [member|member_list]}
  end

  def handle_call(:list_members, _, member_list) do
    {:reply, {Node.self(), member_list}, member_list}
  end
end
