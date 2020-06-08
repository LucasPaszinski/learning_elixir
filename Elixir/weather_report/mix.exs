defmodule WeatherReport.MixProject do
  use Mix.Project

  def project do
    [
      app: :weather_report,
      escript: escript_config(),
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~>1.6.2"},
      {:poison, "~> 4.0.1"}
    ]
  end

  defp escript_config do
    [
      main_module: WeatherReport
    ]
  end
end
