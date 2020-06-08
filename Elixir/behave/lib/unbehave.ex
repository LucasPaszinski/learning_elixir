defmodule Unbehave do
  @behaviour Behave


  @impl Behave
  def behaved? do
    false
  end

  def logistic_map(r \\ 1, x \\ 0.8) do
    result = r*x*(x-1)
    logistic_map(r+1, result)
  end
end
