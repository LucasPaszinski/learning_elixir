defmodule SuperStacka.Stash do
  use GenServer
  @server __MODULE__

  def start_link(init_arg) do
    GenServer.start_link(@server, init_arg, name: @server)
  end

  def get do
    GenServer.call(@server, :get)
  end

  def update(state) do
    GenServer.cast(@server, {:update, state})
  end

  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update, new_state}, _old_state) do
    {:noreply, new_state}
  end
end
