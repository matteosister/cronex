defmodule Cronex.Service do
  use GenServer
  use Timex

  def start_link do
    IO.puts "start_link service"
    GenServer.start_link(__MODULE__, [], name: :service)
  end

  def handle_call(:check, _, state) do
    output_now
    {:reply, state, state}
  end

  def output_now do
    {:ok, now} = Date.now |> DateFormat.format("{ISO}")
    #IO.puts "receive #{now}"
  end
end
