defmodule ChatRoom do
  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:add_member, member}, member_list) do
    Logger.info("Adding a new member #{member} at #{Node.self()}")
    {:noreply, [member|member_list]}
  end

  def handle_call(:list_members, _, member_list) do
    Logger.info("Listing members: #{member_list}")
    {:reply, {Node.self(), member_list}, member_list}
  end
end
