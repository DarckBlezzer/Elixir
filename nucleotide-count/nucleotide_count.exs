defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Enum.count(strand, &(&1 == nucleotide))
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    Map.new(@nucleotides, &{&1, count(strand, &1)})

    # map_initial = Enum.into(@nucleotides, %{}, fn a -> {a, 0} end)

    # Enum.reduce(strand, map_initial, fn letter, map ->
    #   Map.update(map, letter, 1, &(&1 + 1))
    # end)
  end
end

NucleotideCount.histogram('AATAA')
|> IO.inspect()
