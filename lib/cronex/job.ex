defmodule Cronex.Job do
  import Enum
  alias Cronex.Job

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
  %Cronex.Job{s: "0", m: "0", h: "19", d: :all, mon: :all, dow: :all, user: "root", cmd: "test 2" }
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
  def default_values(val), do: val

  @doc """
  iex> Cronex.Job.is_due?(%Cronex.Job{m: "*", h: "*", d: "*", mon: "*", dow: "*" })
  true
  """
  def is_due?(%Job{m: "*", h: "*", d: "*", mon: "*", dow: "*"}), do: true
end
