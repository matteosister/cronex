defmodule Cronex.Service do
  use GenServer
  use Timex

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :service)
  end

  def handle_cast({:check, _}, state) do
    Task.async(&output_now/0)
    {:noreply, state}
  end

  def output_now do
    {:ok, now} = Date.now |> DateFormat.format("{ISO}")
    #IO.puts "receive #{now}"
  end
end
