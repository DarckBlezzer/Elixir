defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(serie :: String.t(), size :: integer) :: list(String.t())
  def slices(serie, size) do
    cond do
      size <= String.length(serie) and size > 0 ->
        [String.slice(serie, 0, size) | slices(String.slice(serie, 1..-1), size)]

      true ->
        []
    end
  end
end
