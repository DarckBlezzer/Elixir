defmodule PigLatin do
  @vocals ["a", "e", "i", "o", "u"]
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&do_translate(&1))
    |> Enum.join(" ")
  end

  defp do_translate(phrase, accum \\ "") do
    <<first_char::binary-1>> <> <<second_char::binary-1>> <> rest = phrase

    cond do
      accum == "" and first_char in ~w(x y) and second_char not in @vocals -> phrase <> "ay"
      first_char <> second_char == "qu" -> rest <> accum <> "quay"
      first_char not in @vocals -> do_translate(second_char <> rest, accum <> first_char)
      true -> phrase <> accum <> "ay"
    end
  end

  # defp do_translate(<<xy::binary-1>> <> <<char::binary-1>> <> rest, "")
  #      when xy in ~w(y x) and char not in @vocals,
  #      do: xy <> char <> rest <> "ay"

  # defp do_translate(<<char::binary-1>> <> rest, accum) do
  #   cond do
  #     char == "q" and String.starts_with?(rest, "u") ->
  #       "u" <> u_rest = rest

  #       u_rest <> accum <> char <> "uay"

  #     char not in @vocals ->
  #       do_translate(rest, accum <> char)

  #     true ->
  #       char <> rest <> accum <> "ay"
  #   end
  # end
end

PigLatin.translate("")
