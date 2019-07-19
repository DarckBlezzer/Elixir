defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @cardinals [:north, :east, :south, :west, :north, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _position)
      when direction not in @cardinals,
      do: {:error, "invalid direction"}

  def create(direction, position = {x, y})
      when is_integer(x) and is_integer(y),
      do: %{direction: direction, position: position}

  def create(_direction, _position),
    do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot

  # turn left
  def simulate(robot, "L" <> rest),
    do: simulate(create_map("L", robot), rest)

  # turn right
  def simulate(robot, "R" <> rest),
    do: simulate(create_map("R", robot), rest)

  # move forward
  def simulate(%{direction: direction, position: position}, "A" <> rest),
    do: simulate(%{direction: direction, position: do_go_forward(direction, position)}, rest)

  # error when instructions not in ["L","R","A"]
  def simulate(_robot, _instructions),
    do: {:error, "invalid instruction"}

  # create map with new direction
  defp create_map(course, %{direction: direction, position: position}),
    do: %{direction: get_cardinal(course, direction), position: position}

  # get new cardinal base on course
  defp get_cardinal(course, direction) do
    value =
      case course do
        "L" -> -1
        _R -> 1
      end

    Enum.at(@cardinals, Enum.find_index(@cardinals, &(&1 == direction)) + value)
  end

  # defp get_cardinal("L", direction),
  #   do: Enum.at(@cardinals, Enum.find_index(@cardinals, &(&1 == direction)) - 1)

  # defp get_cardinal("R", direction),
  #   do: Enum.at(@cardinals, Enum.find_index(@cardinals, &(&1 == direction)) + 1)

  # move forward
  defp do_go_forward(:north, {x, y}), do: {x, y + 1}
  defp do_go_forward(:south, {x, y}), do: {x, y - 1}

  defp do_go_forward(:east, {x, y}), do: {x + 1, y}
  defp do_go_forward(:west, {x, y}), do: {x - 1, y}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: direction}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: position}) do
    position
  end
end
