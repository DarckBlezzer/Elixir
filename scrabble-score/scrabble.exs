defmodule Scrabble do
  @letters_value %{
    "A" => 1,
    "E" => 1,
    "I" => 1,
    "O" => 1,
    "U" => 1,
    "L" => 1,
    "N" => 1,
    "R" => 1,
    "S" => 1,
    "T" => 1,
    "D" => 2,
    "G" => 2,
    "B" => 3,
    "C" => 3,
    "M" => 3,
    "P" => 3,
    "F" => 4,
    "H" => 4,
    "V" => 4,
    "W" => 4,
    "Y" => 4,
    "K" => 5,
    "J" => 8,
    "X" => 8,
    "Q" => 10,
    "Z" => 10
  }
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    String.upcase(word)
    |> do_scored()
  end

  defp do_scored(""), do: 0

  defp do_scored(<<char::binary-1, rest::binary>>) do
    Map.get(@letters_value, char, 0) + do_scored(rest)
    # get_value(char) + do_scored(rest)
  end

  # For not use tail recursion
  # defp get_value(letter) do
  #   cond do
  #     letter in ~w(A E I O U L N R S T) -> 1
  #     letter in ~w(D G) -> 2
  #     letter in ~w(B C M P) -> 3
  #     letter in ~w(F H V W Y) -> 4
  #     letter in ~w(K) -> 5
  #     letter in ~w(J X) -> 8
  #     letter in ~w(Q Z) -> 10
  #     true -> 0
  #   end
  # end

  # defp get_value(letter) when letter in ~w(A E I O U L N R S T), do: 1
  # defp get_value(letter) when letter in ~w(D G), do: 2
  # defp get_value(letter) when letter in ~w(B C M P), do: 3
  # defp get_value(letter) when letter in ~w(F H V W Y), do: 4
  # defp get_value(letter) when letter in ~w(K), do: 5
  # defp get_value(letter) when letter in ~w(J X), do: 8
  # defp get_value(letter) when letter in ~w(Q Z), do: 10
  # defp get_value(_letter), do: 0
end
