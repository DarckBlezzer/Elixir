defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    case Enum.sort([a, b, c]) do
      [x, _y, _z] when x <= 0 -> {:error, "all side lengths must be positive"}
      [x, y, z] when x + y <= z -> {:error, "side lengths violate triangle inequality"}
      [x, x, x] -> {:ok, :equilateral}
      [x, x, _] -> {:ok, :isosceles}
      [_, y, y] -> {:ok, :isosceles}
      _list -> {:ok, :scalene}
    end
  end
end
