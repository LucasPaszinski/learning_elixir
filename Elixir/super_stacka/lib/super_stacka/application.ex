defmodule SuperStacka.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, initial_list) do
    children = [
      # Starts a worker by calling: SuperStacka.Worker.start_link(arg)
      {SuperStacka.Stash, initial_list},
      SuperStacka.Stacker
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :rest_for_one, name: SuperStacka.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
