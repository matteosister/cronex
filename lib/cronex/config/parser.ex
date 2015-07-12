defmodule Cronex.Config.Parser do
  import String
  import Enum
  alias Cronex.Config.Job

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

  @doc """
  iex>Cronex.Config.Parser.convert_to_struct("0 19 * * * root test 2")
  %Cronex.Config.Job{minute: "0", hour: "19", day: "*", month: "*", day_of_week: "*", user: "root", command: "test 2" }
  """
  def convert_to_struct(line) do
    Job.parse(line)
  end
end
