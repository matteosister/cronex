defmodule Cronex.Checker do
  use GenServer
  import Logger

  def tick do
    GenServer.call(:checker, :tick)
  end

  def set_configuration(config) do
    GenServer.cast(:checker, {:config, config})
  end

  def set_configuration_file(config_file) do
    GenServer.cast(:checker, {:config_file, config_file})
  end

  # GenServer implementation
  def start_link do
    log(:debug, "Start checker")
    GenServer.start_link(__MODULE__, [], name: :checker)
  end

  def init(_args) do
    :timer.apply_interval(:timer.seconds(1), __MODULE__, :tick, [])
    {:ok, []}
  end

  @doc """
  sets the checker configuration, it is added to the actual one
  """
  def handle_cast({:config, config}, state) do
    new_state = config ++ state
    log(:debug, "new config: #{IO.inspect new_state}")
    {:noreply, new_state}
  end

  @doc """
  sets the checker configuration file, it is then parsed and the configuration
  gets passed to the :config cast
  """
  def handle_cast({:config_file, config_file}, state) do
    config_file
    |> File.read!
    |> Cronex.Config.Parser.parse_configuration
    |> set_configuration
    {:noreply, state}
  end

  @doc """
  tick every x amount of time and calls the :service GenServer
  """
  def handle_call(:tick, _, config) do
    GenServer.cast(:service, {:check, config})
    {:noreply, config}
  end
end
