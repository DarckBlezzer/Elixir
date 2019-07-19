defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    0..(limit - 1)
    |> Stream.filter(&multiple?(&1, factors))
    |> Enum.sum()

    # do_get_factors(limit, factors)
    # |> Enum.uniq()
    # |> Enum.sum()
  end

  defp multiple?(num, factors), do: Enum.any?(factors, &(rem(num, &1) == 0))

  # This is better in performance, but other is shorter and simple
  # defp do_get_factors(limit, factors, count \\ 0, accum \\ [])

  # defp do_get_factors(_limit, [], _count, accum), do: accum

  # defp do_get_factors(limit, factors = [head | _tail], count, accum)
  #      when count < limit,
  #      do: do_get_factors(limit, factors, count + head, [count | accum])

  # defp do_get_factors(limit, [_head | tail], _count, accum),
  #   do: do_get_factors(limit, tail, 0, accum)
end
