defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  # @regex_find_abbreviations ~r/[\s\da-z,-](?<! [a-z])/
  @regex_find_abbreviations ~r/(?!\b)[a-z]|\W/
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(@regex_find_abbreviations, "")
    |> String.upcase()
  end
end

# Acronym.abbreviate("Portable Networks Graphic")
# |> IO.inspect()
