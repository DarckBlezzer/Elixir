defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2),
    do: {:error, "Lists must be the same length"}

  def hamming_distance(strand1, strand2) when strand1 === strand2, do: {:ok, 0}

  def hamming_distance(strand1, strand2) do
    count = Enum.zip(strand1, strand2) |> Enum.count(&(elem(&1, 0) != elem(&1, 1)))

    {:ok, count}
  end

  # defp check_strands({char1, char2}, acc) when char1 == char2, do: acc
  # defp check_strands(_chars, acc), do: acc + 1
end
