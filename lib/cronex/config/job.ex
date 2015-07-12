defmodule Cronex.Config.Job do
  import Enum

  defstruct minute: :all,
    hour: :all,
    day: :all,
    month: :all,
    day_of_week: :all,
    user: nil,
    command: nil

  def parse(config_line) do
    vars = config_line
    |> String.split(~r{\s}, trim: true, parts: 7)
    %Cronex.Config.Job{
      minute: at(vars, 0),
      hour: at(vars, 1),
      day: at(vars, 2),
      month: at(vars, 3),
      day_of_week: at(vars, 4),
      user: at(vars, 5),
      command: at(vars, 6)
      }
  end
end
