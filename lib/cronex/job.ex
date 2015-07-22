defmodule Cronex.Job do
  import Enum
  alias Cronex.Job
  use Timex

  defstruct [
    s: :all,
    m: :all,
    h: :all,
    d: :all,
    mon: :all,
    dow: :all,
    user: nil,
    cmd: nil
  ]

  @doc """
  iex>Cronex.Job.parse("0 0 19 * * * root test 2")
  %Cronex.Job{s: 0, m: 0, h: 19, d: :all, mon: :all, dow: :all, user: "root", cmd: "test 2" }

  iex>Cronex.Job.parse("* 0 19 * * * root test 2")
  %Cronex.Job{s: :all, m: 0, h: 19, d: :all, mon: :all, dow: :all, user: "root", cmd: "test 2" }
  """
  def parse(config_line) do
    vars = config_line
    |> String.split(~r{\s}, trim: true, parts: 8)
    |> Enum.map(&default_values/1)

    job = %Job{
      s: at(vars, 0),
      m: at(vars, 1),
      h: at(vars, 2),
      d: at(vars, 3),
      mon: at(vars, 4),
      dow: at(vars, 5),
      user: at(vars, 6),
      cmd: at(vars, 7)
      }
  end

  def default_values("*"), do: :all
  def default_values(val) when is_binary(val) do
    case Integer.parse(val) do
      {int, _} -> int
      :error -> val
    end
  end
  def default_values(val), do: val

  @doc """
  iex> Cronex.Job.is_due?(%Cronex.Job{s: :all, m: :all, h: :all, d: :all, mon: :all, dow: :all }, Timex.Date.now)
  true

  iex> Cronex.Job.is_due?(%Cronex.Job{s: 0, m: :all, h: :all, d: :all, mon: :all, dow: :all }, Timex.Date.from({{2015, 1, 1}, {0, 0, 1}}))
  false

  iex> Cronex.Job.is_due?(%Cronex.Job{s: 20, m: :all, h: :all, d: :all, mon: :all, dow: :all }, Timex.Date.from({{2015, 1, 1}, {0, 0, 20}}))
  true
  """
  def is_due?(%Job{s: :all, m: :all, h: :all, d: :all, mon: :all, dow: :all}, _), do: true
  def is_due?(%Job{s: s, m: :all, h: :all, d: :all, mon: :all, dow: :all}, %DateTime{second: check_s}), do: s == check_s
end
