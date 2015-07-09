defmodule Cronex.Checker do

  def start_link do
    check
  end

  defp check do
    GenServer.call :service, :check
    :timer.sleep(1000)
    check
  end
end
