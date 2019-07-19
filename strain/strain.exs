defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    # for x <- list, fun.(x), do: x
    do_filter(list, fun, true)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    # for x <- list, !fun.(x), do: x
    do_filter(list, fun, false)
  end

  defp do_filter([], _fun, _operator), do: []

  defp do_filter([head | tail], fun, operator) do
    if fun.(head) == operator do
      [head | do_filter(tail, fun, operator)]
    else
      do_filter(tail, fun, operator)
    end
  end
end
