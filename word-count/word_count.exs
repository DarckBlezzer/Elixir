defmodule Words do
  @regex_split ~r/[^[:alnum:]-]/u

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(@regex_split, trim: true)
    |> Enum.reduce(%{}, &update_map/2)

    # |> String.split(~r/[^a-zß-öø-ÿ\d-]+/)
    # |> String.split(~r/[^\p{L}-\d]/u, trim: true)

    # Alternative for reduce, list is the result of separated words, in this example every word is search for count
    # for n <- list, into: %{}, do: {n, Enum.count(list, &(&1 == n))}

    # Alternative to FOR, list is the result of separated words, in this example every word is search for count
    # Enum.map(list, fn x ->
    #   cant = Enum.count(list, &(&1 == x))
    #   {x, cant}
    # end)
    # |> Enum.into(%{})
  end

  defp update_map(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end

Words.count("Texto de : ejemplo co-texto texto_de!! 1, 2  ejemplo Freude schöner Götterfunken")
|> IO.inspect()
