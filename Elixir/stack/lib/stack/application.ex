defmodule Stack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def main(args) do
    start(nil, args)
  end

  def start(_type, args) do
    children = [
      # Starts a worker by calling: Stack.Worker.start_link(arg)
      {Stack.Stack, args}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
