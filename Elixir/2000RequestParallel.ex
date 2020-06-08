defmodule Rec do
  def receiver(n) do
    receive do
      {:msg} ->
        receiver(n + 1)

      {:finish} ->
        IO.puts("Finish #{inspect(NaiveDateTime.utc_now())}")
    end
  end

  def wait_return(to, last \\ false) do
    :timer.sleep(2000)

    case last do
      true ->
        send(to, {:msg})

      false ->
        send(to, {:finish})
    end
  end
end

{time, result} = :timer.tc(fn ->
  IO.puts("Started #{inspect(NaiveDateTime.utc_now())}")
  pid = spawn(Rec, :receiver, [0])
  run2000 = fn -> for n <- 1..2000, do: spawn(Rec, :wait_return, [pid]) end
  spawn(Rec, :wait_return, [pid, true])
  run2000.()
end)
