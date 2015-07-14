defmodule Cronex do
  use Application

  def start(_type, _args) do
    Cronex.Supervisor.start_link
  end
end
