defmodule ProteinTranslation do
  @rna_map %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @rna_keys [
    "UGU",
    "UGC",
    "UUA",
    "UUG",
    "AUG",
    "UUU",
    "UUC",
    "UCU",
    "UCC",
    "UCA",
    "UCG",
    "UGG",
    "UAU",
    "UAC",
    "UAA",
    "UAG",
    "UGA"
  ]

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    do_get_rna(rna, [])
  end

  defp do_get_rna("", accum), do: {:ok, accum}

  defp do_get_rna(<<codon::binary-3>> <> rest, accum) do
    case of_codon(codon) do
      {:error, _message} -> {:error, "invalid RNA"}
      {:ok, "STOP"} -> {:ok, accum}
      {:ok, protein} -> do_get_rna(rest, accum ++ [protein])
    end
  end

  # def of_rna(rna) do
  #   list = for <<x::binary-3 <- rna>>, do: x
  #   # list = String.split(rna, ~r/.{3}/, include_captures: true, trim: true)

  #   if Enum.all?(list, &(&1 in @rna_keys)) do
  #     result =
  #       Enum.reduce_while(list, [], fn l, acc ->
  #         if @rna_map[l] != "STOP", do
  #           {:cont, acc ++ [@rna_map[l]]}
  #         else
  #           {:halt, acc}
  #         end
  #       end)

  #     {:ok, result}
  #   else
  #     {:error, "invalid RNA"}
  #   end
  #   # do_rna(rna)
  #   # result
  # end

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) when codon in @rna_keys do
    {:ok, @rna_map[codon]}
  end

  def of_codon(_codon), do: {:error, "invalid codon"}
end

strand = "UGGUGUUAUUAAUGGUUU"

ProteinTranslation.of_rna(strand)
|> IO.inspect()
