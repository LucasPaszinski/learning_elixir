defmodule SuperStackaTest do
  use ExUnit.Case
  doctest SuperStacka

  test "greets the world" do
    assert SuperStacka.hello() == :world
  end
end
