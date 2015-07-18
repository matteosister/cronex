defmodule Cronex.Service do
  use GenServer
  use Timex
  import Logger

  def start_link do
    log(:debug, "Start service")
    GenServer.start_link(__MODULE__, [], name: :service)
  end

  def handle_cast({:check, _config}, state) do
    #log(:debug, config)
    {:noreply, state}
  end
end
