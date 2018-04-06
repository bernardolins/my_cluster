defmodule LockServer do
  def start_link(state) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:swarm, :begin_handoff}, _from, state) do
    IO.puts "BEGIN HANDOFF"
    {:reply, {:resume, state}, state}
  end

  def handle_cast({:swarm, :end_handoff, state}, _state) do
    IO.puts "END HANDOFF"
    {:noreply, state}
  end

  def handle_cast(:work, state) do
    IO.puts("Working #{Node.self()}")
    {:noreply, "CHANGED BITCH!"}
  end

  def handle_call(:work, _, state) do
    IO.puts("Call Working #{Node.self()}")
    IO.puts(state)
    {:reply, [Node.self(), state], state}
  end
end
