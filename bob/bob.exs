defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      is_uppercase?(input) and is_asking?(input) ->
        "Calm down, I know what I'm doing!"

      is_asking?(input) ->
        "Sure."

      is_uppercase?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp is_asking?(input), do: String.ends_with?(input, "?")

  defp is_uppercase?(input) do
    upper_case = String.upcase(input)
    input == upper_case and upper_case != String.downcase(input)
    # input == String.upcase(input) and input =~ ~r/\p{L}/
  end
end
