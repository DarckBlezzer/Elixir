defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      |> IO.inspect(label: angram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  # @alphabet ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  @alphabet ?a..?z
  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    char_list =
      sentence
      |> String.downcase()
      |> to_charlist()

    # |> String.graphemes()

    Enum.all?(@alphabet, &(&1 in char_list))

    # 26 ==
    #   sentence
    #   |> String.downcase()
    #   |> String.replace(~r/[^a-z]/, "")
    #   |> String.graphemes()
    #   |> Enum.uniq()
    #   |> length()
  end
end

Pangram.pangram?("Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich.")
|> IO.inspect()
