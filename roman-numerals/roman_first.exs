defmodule Roman do
  @roman_numerals %{
    1 => %{1 => "I", 2 => "IV", 3 => "V", 4 => "IX"},
    2 => %{1 => "X", 2 => "XL", 3 => "L", 4 => "XC"},
    3 => %{1 => "C", 2 => "CD", 3 => "D", 4 => "CM"},
    4 => %{1 => "M", 2 => "IV", 3 => "V", 4 => "IX"}
  }
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    {_position, roman_number} =
      number
      |> Integer.digits()
      |> Enum.reverse()
      |> Enum.reduce({1, ""}, fn number, {position, accum} ->
        {position + 1, do_convert_number_roman(number, position) <> accum}
      end)

    roman_number
  end

  defp do_convert_number_roman(number, position) do
    cond do
      number == 0 ->
        ""

      number == 9 ->
        @roman_numerals[position][4]

      number >= 5 ->
        @roman_numerals[position][3] <> String.duplicate(@roman_numerals[position][1], number - 5)

      number == 4 ->
        @roman_numerals[position][2]

      true ->
        String.duplicate(@roman_numerals[position][1], number)
    end
  end
end
