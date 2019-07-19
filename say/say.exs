defmodule Say do
  @dict %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }
  @numbers Map.keys(@dict)
  @billion 1_000_000_000
  @millon 1_000_000
  @thousand 1_000
  @hundred 100
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {:ok, String.t()} | {:error, String.t()}
  def in_english(number) when number < 0 or number > 999_999_999_999,
    do: {:error, "number is out of range"}

  def in_english(0), do: {:ok, "zero"}
  def in_english(number), do: {:ok, String.trim(say_num(number))}

  defp say_num(num) do
    cond do
      num == 0 ->
        ""

      num >= @billion ->
        say_num(div(num, @billion)) <> " " <> "billion" <> " " <> say_num(rem(num, @billion))

      num >= @millon ->
        say_num(div(num, @millon)) <> " " <> "million" <> " " <> say_num(rem(num, @millon))

      num >= @thousand ->
        say_num(div(num, @thousand)) <> " " <> "thousand" <> " " <> say_num(rem(num, @thousand))

      num >= @hundred ->
        say_num(div(num, @hundred)) <> " " <> "hundred" <> " " <> say_num(rem(num, @hundred))

      num in @numbers ->
        @dict[num]

      true ->
        say_num(10 * div(num, 10)) <> "-" <> say_num(rem(num, 10))
    end
  end
end
