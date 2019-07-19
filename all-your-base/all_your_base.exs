defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  defguard is_valid?(digits, base_a, base_b) when base_a < 2 or base_b < 2 or length(digits) == 0

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) when is_valid?(digits, base_a, base_b),
    do: nil

  def convert(digits, base_a, base_b) do
    if Enum.any?(digits, &(&1 < 0 or &1 >= base_a)) do
      nil
    else
      start_convert(digits, base_a)
      |> do_convert_to_base_x(base_b)
    end

    # do_convert_to_base_10(digits, base_a, length, 0)
    # |> do_convert_to_base_x(base_b)
  end

  defp start_convert(digits, 10), do: Integer.undigits(digits)

  defp start_convert(digits, base_a) do
    length = length(digits) - 1

    {_base, _exponent, result} =
      Enum.reduce(digits, {base_a, length, 0}, &do_convert_to_base_10/2)

    result
  end

  defp do_convert_to_base_10(number, {base, exponent, accum}) do
    sum = number * round(:math.pow(base, exponent)) + accum
    {base, exponent - 1, sum}
  end

  # First Try
  # conver base x to base 10
  # defp do_convert_to_base_10([head | _tail], base, _exponent, _accum)
  #      when head < 0 or head >= base,
  #      do: nil

  # defp do_convert_to_base_10([], _base, _exponent, accum), do: accum

  # defp do_convert_to_base_10([head | tail], base, exponent, accum) do
  #   sum = head * round(:math.pow(base, exponent)) + accum
  #   do_convert_to_base_10(tail, base, exponent - 1, sum)
  # end

  # convert base 10 to base x
  defp do_convert_to_base_x(number, base, remainder \\ [])

  defp do_convert_to_base_x(number, base, _remainder)
       when base == 10,
       do: Integer.digits(number)

  defp do_convert_to_base_x(number, base, remainder)
       when number < base,
       do: [number | remainder]

  defp do_convert_to_base_x(number, base, remainder) do
    rest = div(number, base)
    rem = rem(number, base)
    do_convert_to_base_x(rest, base, [rem | remainder])
  end

  # second try, but i don't like it for, not compresible
  # defp do_convert_to_base_x(0, base, _remainder), do: [0]

  # defp do_convert_to_base_x(number, base, _remainder) do
  #   Stream.iterate(
  #     {div(number, base), rem(number, base)},
  #     &{div(elem(&1, 0), base), rem(elem(&1, 0), base)}
  #   )
  #   |> Enum.take_while(&(&1 != {0, 0}))
  #   |> Keyword.values()
  #   |> Enum.reverse()
  # end
end
