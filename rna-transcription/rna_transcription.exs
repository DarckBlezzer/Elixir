defmodule RNATranscription do
  @rna_complements %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    do_convertion_to_rna(dna)
  end

  # Final result
  defp do_convertion_to_rna([]), do: []

  defp do_convertion_to_rna([head | tail]),
    do: [@rna_complements[head]] ++ do_convertion_to_rna(tail)

  # try one
  # defp do_convertion_to_rna([]), do: []
  # defp do_convertion_to_rna([head | tail]) when head == ?G, do: 'C' ++ do_convertion_to_rna(tail)
  # defp do_convertion_to_rna([head | tail]) when head == ?C, do: 'G' ++ do_convertion_to_rna(tail)
  # defp do_convertion_to_rna([head | tail]) when head == ?T, do: 'A' ++ do_convertion_to_rna(tail)
  # defp do_convertion_to_rna([head | tail]) when head == ?A, do: 'U' ++ do_convertion_to_rna(tail)

  # Try two
  # defp do_convertion_to_rna([]), do: []
  # defp do_convertion_to_rna([?G | tail]), do: 'C' ++ do_convertion_to_rna(tail)
  # defp do_convertion_to_rna([?C | tail]), do: 'G' ++ do_convertion_to_rna(tail)
  # defp do_convertion_to_rna([?T | tail]), do: 'A' ++ do_convertion_to_rna(tail)
  # defp do_convertion_to_rna([?A | tail]), do: 'U' ++ do_convertion_to_rna(tail)
end

RNATranscription.to_rna('ACTG')
|> IO.inspect()
