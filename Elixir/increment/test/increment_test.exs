defmodule IncrementTest do
  use ExUnit.Case
  doctest Increment

  test "greets the world" do
    assert Increment.hello() == :world
  end
end
