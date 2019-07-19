defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()

  def calc(input) when is_integer(input) and input > 0, do: do_calc(input, 0)
  # def calc(_), do: raise(FunctionClauseError)

  # defp do_calc(n, count \\ 0)
  defp do_calc(1, count), do: count

  defp do_calc(input, count) when rem(input, 2) == 0,
    do: div(input, 2) |> do_calc(count + 1)

  defp do_calc(input, count),
    do: do_calc(input * 3 + 1, count + 1)

  # def calc(input, count \\ 0)

  # def calc(1, count), do: count

  # def calc(input, count) when input > 1 and is_number(input) do
  #   new_input =
  #     if rem(input, 2) == 0 do
  #       div(input, 2)
  #     else
  #       input * 3 + 1
  #     end

  #   calc(new_input, count + 1)
  # end
end
