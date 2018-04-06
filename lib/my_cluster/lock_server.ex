defmodule LockServer do
  def start_link(state) do
    IO.puts("Starting link #{inspect state}")
    GenServer.start_link(__MODULE__, state)
  end

  def init(state) do
    IO.puts("Init #{inspect state}")
    {:ok, state}
  end

  def start_many(amount, start_from \\ 0) do
    Enum.map(0..(amount-1), fn i ->
      #name = RandomBinary.generate()
      #|> String.to_atom
      name = UUID.uuid1() |> String.to_atom

      Swarm.register_name(name, LockServer, :start_link, [{i+start_from, "FIRST STATE"}])

      name
    end)
  end

  def start_processinhos(amount, start_from \\ 0) do
    Enum.map(0..(amount-1), fn i ->
      name = :"processinho_#{i+start_from}"

      Swarm.register_name(name, LockServer, :start_link, [{i+start_from, "FIRST STATE (processinho)"}])

      name
    end)
  end

  def start_processinhos_reverse(amount, start_from \\ 0) do
    Enum.map(0..(amount-1), fn i ->
      name = :"processinho_#{amount+start_from-i}"

      Swarm.register_name(name, LockServer, :start_link, [{amount+start_from-i, "FIRST STATE (processinho)"}])

      name
    end)
  end

  def change_many(names) do
    Enum.each(names, fn name ->
      GenServer.cast({:via, :swarm, name}, :change)
    end)
  end

  def talk_many(names) do
    Enum.each(names, fn name ->
      GenServer.call({:via, :swarm, name}, :talk)
    end)
  end

  def count do
    :erlang.processes()
    |> Enum.count(fn pid ->
      initial_call = pid
      |> Process.info
      |> get_in([:dictionary, :"$initial_call"])

      initial_call == {LockServer, :init, 1}
    end)
  end

  def handle_call({:swarm, :begin_handoff}, _from, {i, _} = state) do
    IO.puts "BEGIN HANDOFF #{i}"
    {:reply, {:resume, state}, state}
  end

  def handle_cast({:swarm, :end_handoff, {i, _} = state}, _state) do
    IO.puts "END HANDOFF #{i}"
    {:noreply, state}
  end

  def handle_cast(:change, {i, _} = state) do
    IO.puts("Changing state of process##{i} (#{Node.self()})")
    {:noreply, "CHANGED BITCH!"}
  end

  def handle_call(:talk, _, {i, msg} = state) do
    IO.puts("Message of process##{i} (#{Node.self()}): #{msg}")
    {:reply, [Node.self(), state], state}
  end

  def handle_info({:swarm, :die}, {i, msg} = state) do
    IO.puts("DIIIIIIEEEEEEEE!!!!!!!!  process##{i} (#{Node.self()}): #{msg}")
    {:stop, :shutdown, state}
  end
end
