defmodule Fib do
  def of(n) when n < 2 do
    n
  end

  def of(n) do
    of(n-1)+of(n-2)
  end
end

IO.puts "Start the task"
worker = Task.async(fn -> Fib.of(20) end)
IO.puts "Hey the task is runing and i'm still here talking to you"
IO.puts "Well ..  we have to wait for it"
result = Task.await(worker)
IO.puts "Finally, the result is #{result}"
