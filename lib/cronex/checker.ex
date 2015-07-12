defmodule Cronex.Checker do
  use GenServer
  use Timex

  def start_link do
    start_timer
    GenServer.start_link(__MODULE__, [], name: :checker)
  end

  def start_timer do
    :timer.apply_interval(1000, __MODULE__, check, [])
  end

  defp check do
    {:ok, now} = Date.now |> DateFormat.format("{ISO}")
    IO.puts "cast #{now}"
    GenServer.cast :service, {:check, nil}
  end
end
