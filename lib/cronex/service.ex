defmodule Cronex.Service do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :service)
  end

  def handle_call(:check, _from, state) do
    IO.puts('check')
    {:reply, state, state}
  end
end
