defmodule SuperStacka.MixProject do
  use Mix.Project

  def project do
    [
      app: :super_stacka,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [initial_list: [1,2,3,4,5,6,7,8,9,10]],
      mod: {SuperStacka.Application, []},
      # # register unique name acros node or cluster
      # registered: [
      #   SuperStacka.Server,
      # ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 2.1.1", runtime: false}
    ]
  end
end
