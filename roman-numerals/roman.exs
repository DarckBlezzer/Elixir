defmodule Roman do
  @roman_numerals [
    {9000, "IX"},
    {5000, "V"},
    {4000, "IV"},
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    @roman_numerals
    |> Enum.find(&(elem(&1, 0) <= number))
    |> case do
      {arabic, roman} -> "#{roman}#{numerals(number - arabic)}"
      _ -> ""
    end
  end
end
