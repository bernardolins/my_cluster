defmodule LockServer do
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_cast(:work, state) do
    IO.puts("Working #{Node.self()}")
    {:noreply, state}
  end
end
