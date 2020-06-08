defmodule Stack do
  @server __MODULE__.Server

  def main(args) do
    start(args)
  end

  def start(enum) do
    GenServer.start_link(@server, enum)
  end

  def pop do
    GenServer.call(@server, :pop)
  end

  def push(item) do
    GenServer.cast(@server, {:push, item})
  end

  defmodule Server do
    use GenServer

    def init(stack) do
      {:ok, stack}
    end

    def handle_call(:pop, _from, [head | tail]) do
      {:reply, head, tail}
    end

    def handle_cast({:push, item}, _from, enum) do
      {:noreply, [item | enum]}
    end
  end
end
