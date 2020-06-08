defmodule WeatherReportTest do
  use ExUnit.Case
  doctest WeatherReport

  test "greets the world" do
    assert WeatherReport.hello() == :world
  end
end
