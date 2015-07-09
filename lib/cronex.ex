defmodule Cronex do
  use Application

  def main(args) do
    #IO.puts "main"
    args |> parse_args
  end

  def start(_type, _args) do
    #IO.puts "start"
    Cronex.Supervisor.start_link
  end

  def parse_args(args) do
    options = OptionParser.parse(args)
    IO.inspect options
    case options do
      {[go: true], _, _} -> IO.puts "go!"
      {_, _, _}          -> IO.puts "Welcome to Cronex!"
    end
  end
end
