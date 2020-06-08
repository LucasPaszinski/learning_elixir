defmodule SuperStacka.Stacker do
  use GenServer

  #project version
  @vsn 0

  @server __MODULE__

  def start_link(_) do
    GenServer.start_link(@server, SuperStacka.Stash.get(), name: @server)
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push({:head, value}) do
    GenServer.cast(@server, {:push, :head, value})
  end

  def push({:tail, value}) do
    GenServer.cast(@server, {:push, :tail, value})
  end

  def push(value) do
    push({:tail, value})
  end

  # Callbacks
  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_call(:pop, _from, []) do
    {:reply, [], []}
  end

  def handle_cast({:push, :head, element}, state) do
    {:noreply, [element | state]}
  end

  def handle_cast({:push, :tail, element}, state) do
    {:noreply, [state | element]}
  end

  def terminate(_reason, state) do
    SuperStacka.Stash.update(state)
  end
end
