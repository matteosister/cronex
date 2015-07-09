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
    |> String.split(~r{\s}, trim: true)
    %Cronex.Config.Job{minute: at(vars, 0), hour: at(vars, 1), day: at(vars, 3), month: at(vars, 4), day_of_week: at(vars, 5), user: at(vars, 6), command: at(vars, 7)}
  end
end
