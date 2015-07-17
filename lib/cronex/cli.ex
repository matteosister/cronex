defmodule Cronex.CLI do
  def run(argv) do
    parse_args(argv)
  end

  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
    case parse do
      { [help: true], _, _ } -> :help
      { _, _, [{"-c", config_file}]} -> {config_file}
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: cronex -c <config_file>
    """
  end

  def process({config_file}) do
    res = File.read(config_file)
    case res do
      {:error, _} -> IO.puts "impossible to open file #{config_file}"
      {:ok, content} -> parse_configuration(content)
    end
  end

  def parse_configuration(content) do
    content
    |> Cronex.Config.Parser.parse_configuration
    |> Cronex.Checker.set_configuration
    #loop
  end

  def loop, do: loop
end
