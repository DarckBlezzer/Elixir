defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    result =
      sentence
      |> String.replace(~r/[^a-zA-Z]/, "")
      |> String.graphemes()

    Enum.uniq(result) == result

    # result =
    #   sentence
    #   |> String.downcase()
    #   |> String.replace(~r/[^a-z]/, "")
    #   |> String.graphemes()
    #   |> Enum.sort()

    # Enum.uniq(result) == result

    # {result, _rest} =
    #   sentence
    #   |> String.downcase()
    #   |> String.replace(~r/[^a-z]/, "")
    #   |> String.graphemes()
    #   |> Enum.reduce_while({true, []}, &validate/2)

    # result
  end

  # defp validate(char, {_validation, accum}) do
  #   if char in accum do
  #     {:halt, {false, accum}}
  #   else
  #     {:cont, {true, [char | accum]}}
  #   end
  # end
end
