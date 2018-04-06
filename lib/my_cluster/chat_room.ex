defmodule ChatRoom do

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:add_member, member}, member_list) do
    {:noreply, [member|member_list]}
  end

  def handle_call(:list_members, _, member_list) do
    {:reply, {Node.self(), member_list}, member_list}
  end
end
