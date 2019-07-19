defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, &next_prime/1)
    |> Enum.at(count - 1)

    # first try
    # {number, _is_prime} =
    #   Stream.iterate({1, false}, &do_create_body/1)
    #   |> Stream.filter(&elem(&1, 1))
    #   |> Enum.at(count - 1)
    # number
  end

  def nth(_count), do: raise("Number need to be uppter than 0")

  defp next_prime(number) do
    if is_prime?(number + 1), do: number + 1, else: next_prime(number + 1)
  end

  # defp do_create_body({number, _acc}), do: {number + 1, is_prime?(number + 1)}

  defp is_prime?(2), do: true

  defp is_prime?(number) do
    not Enum.any?(2..ceil(number / 2), &(rem(number, &1) == 0))
  end
end
