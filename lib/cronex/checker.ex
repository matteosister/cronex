defmodule Cronex.Checker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :checker)
  end

  def init(args) do
    :timer.apply_interval(:timer.seconds(1), __MODULE__, :tick, [])
  end

  def tick do
    GenServer.call(:service, :check)
  end

  def handle_call(:timer, _from, state) do
    IO.inspect state
    {:reply, state, state}
  end
end
