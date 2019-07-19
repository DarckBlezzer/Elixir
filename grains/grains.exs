defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number < 1 or number > 64,
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  def square(number), do: {:ok, :math.pow(2, number - 1) |> round()}

  # def square(number) do
  #   result =
  #     Stream.iterate(1, &(&1 + &1))
  #     |> Enum.at(number - 1)

  #   {:ok, result}
  # end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: {:ok, 18_446_744_073_709_551_615}
end
