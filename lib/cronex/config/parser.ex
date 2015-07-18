defmodule Cronex.Config.Parser do
  import String
  import Enum
  alias Cronex.Job

  def parse_file(file) do
    res = File.read(file)
    case res do
      {:error, _} -> IO.puts "impossible to open file #{file}"
      {:ok, content} -> parse_configuration(content)
    end
  end

  def parse_configuration(content) do
    content
    |> split_lines
    |> strip_comment_lines
  end

  def split_lines(content) do
    split(content, ~r{\n}, trim: true)
  end

  def strip_comment_lines(lines) do
    filter lines, &(not starts_with? &1, "#")
  end
end
