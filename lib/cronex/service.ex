defmodule Cronex.Service do
  use GenServer
  use Timex
  import Logger

  def start_link do
    Logger.log(:debug, "Start service")
    GenServer.start_link(__MODULE__, [], name: :service)
  end

  def handle_call(:check, _, state) do
    output_now
    {:reply, state, state}
  end

  def output_now do
    {:ok, now} = Date.now |> DateFormat.format("{ISO}")
  end
end
