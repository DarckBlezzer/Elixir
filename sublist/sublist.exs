defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      do_contains?(a, b) -> :superlist
      do_contains?(b, a) -> :sublist
      true -> :unequal
    end
  end

  # defp do_contains?(list, sub) when length(sub) > length(list), do: false

  # defp do_contains?(list, sub) do
  #   Enum.take(list, length(sub)) === sub || do_contains?(tl(list), sub)
  # end

  defp do_contains?(list, sub) do
    sub_count = length(sub)

    cond do
      sub_count > length(list) ->
        false

      Enum.take(list, sub_count) === sub ->
        true

      true ->
        do_contains?(tl(list), sub)
    end
  end
end
