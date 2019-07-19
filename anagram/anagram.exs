defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &is_anagram?(base, &1))
  end

  defp is_anagram?(base, word) do
    not is_same_word?(base, word) and do_convert(base) == do_convert(word)
  end

  defp is_same_word?(word1, word2), do: String.downcase(word1) == String.downcase(word2)

  defp do_convert(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
