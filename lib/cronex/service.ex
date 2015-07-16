defmodule Cronex.Service do
  use GenServer
  use Timex
  import Logger

  def start_link do
    log(:debug, "Start service")
    GenServer.start_link(__MODULE__, [], name: :service)
  end

  def handle_cast({:check, config}, state) do
    IO.inspect config
    {:noreply, state}
  end

  def output_now do
    {:ok, now} = Date.now |> DateFormat.format("{ISO}")
    log(:debug, now)
  end
end
