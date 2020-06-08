defmodule Sequence.SecretAgent do
  use Agent

  def start_link(state) do
    IO.puts "Secret Agent In Position"
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def get do
    IO.puts "Yo!"
    Agent.get(__MODULE__, & &1)
  end

  def update(new_state) do
    IO.puts "Yo!"
    Agent.update(__MODULE__, fn _old_state ->  new_state end)
  end
end
