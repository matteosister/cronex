defmodule Cronex.Checker do
  use GenServer
  import Logger

  def tick do
    GenServer.call(:checker, :tick)
  end

  def set_configuration(config) do
    GenServer.cast(:checker, {:config, config})
  end

  # GenServer implementation
  def start_link do
    log(:debug, "Start checker")
    GenServer.start_link(__MODULE__, [], name: :checker)
  end

  def init(args) do
    :timer.apply_interval(:timer.seconds(1), __MODULE__, :tick, [])
    {:ok, []}
  end

  def handle_cast({:config, config}, state) do
    {:noreply, config ++ state}
  end

  def handle_call(:tick, _, configuration) do
    GenServer.cast(:service, {:check, configuration})
    {:noreply, configuration}
  end
end
