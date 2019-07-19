defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db, name, grade) do
    Map.update(db, grade, [name], &Enum.sort([name | &1]))
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    Map.to_list(db)
    |> List.keysort(0)
  end
end

# Test sort
# {_nothing, db} =
#   Enum.map_reduce(1..1000, %{}, fn x, acc ->
#     name = "Alumno#{x}"

#     {x, Map.update(acc, :rand.uniform(100), [name], &Enum.sort([name | &1]))}
#   end)

# Map.to_list(db)
# |> List.keysort(0)
# |> IO.inspect()
