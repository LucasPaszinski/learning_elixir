defmodule Sequence.Server do
  use GenServer

  @server __MODULE__

  # External code
  def start_link(_) do
    GenServer.start_link(@server, nil, name: @server)
  end

  def next_number do
    GenServer.call(@server, :next_number)
  end

  def increment_delta(delta) do
    GenServer.cast(@server, {:increment_number, delta})
  end

  # Internal

  def init(_) do
    {:ok, Sequence.SecretAgent.get()}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_cast({:increment_number, new_number}, current_number) do
    {:noreply, current_number + new_number}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and i'm happy with it"}]]
  end

  def terminate(_reason, current_number) do
    Sequence.SecretAgent.update(current_number)
  end
end
