defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  # in map beffore 32 elements are ordered and after 32 they aren't
  # to preserve order with large size of elements, use list of tuples
  @raindrop_speak [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}]
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result =
      Enum.reduce(@raindrop_speak, "", fn {key, raindrop}, acc ->
        if rem(number, key) == 0, do: acc <> raindrop, else: acc
      end)

    if result == "", do: "#{number}", else: result
  end

  # My 3 try, used filter and reduce
  # @raindrop_speak
  # |> Enum.filter(fn {n, _} -> rem(number, n) == 0 end)
  # |> Enum.reduce("", fn {_key, value}, accum -> "#{accum}#{value}" end)

  # My 2 try, iterate from 1 to "number" given
  # result =
  #   Enum.filter(1..number, &(rem(number, &1) == 0))
  #   |> Enum.reduce("", &"#{&2}#{@raindrop_speak[&1]}")

  # example of how to pipeline a if
  # |> (&if(&1 == "", do: "#{number}", else: &1)).()

  # My 1 try, Example how to get factors from number with tail call
  # defp do_factors(number, count) when rem(number, count) == 0 do
  #   [count | do_factors(number, count + 1)]
  # end

  # defp do_factors(number, count) when count <= number do
  #   do_factors(number, count + 1)
  # end

  # defp do_factors(_number, _count), do: []
end
