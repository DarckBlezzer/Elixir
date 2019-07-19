defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(~r/(.)\1*/, string)
    |> Enum.map_join(&count_letters/1)
  end

  defp count_letters([letters, char]) do
    size = do_get_size(letters)
    "#{size}#{char}"
  end

  defp do_get_size(letters) do
    if (cant = String.length(letters)) > 1, do: cant, else: ""
  end

  # ----------- Encoder ----------------
  # First try by my own
  # defp do_encode(string, accum \\ "", count \\ 1)

  # defp do_encode("", accum, _count), do: accum

  # defp do_encode(<<char1::binary-1>> <> <<char2::binary-1>> <> rest, accum, count)
  #      when char1 == char2,
  #      do: do_encode(char2 <> rest, accum, count + 1)

  # defp do_encode(<<char1::binary-1>> <> rest, accum, count) when count == 1,
  #   do: do_encode(rest, "#{accum}#{char1}", 1)

  # defp do_encode(<<char1::binary-1>> <> rest, accum, count),
  #   do: do_encode(rest, "#{accum}#{count}#{char1}", 1)

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(\d+)(.)|./, string)
    |> Enum.map_join(&create_letters/1)
  end

  defp create_letters([char]), do: char

  defp create_letters([_, number, char]), do: String.duplicate(char, String.to_integer(number))

  # ----------- Decode ----------------
  # First try by my own
  # defp do_decode(string, number \\ "", accum \\ "")

  # defp do_decode("", _number, accum), do: accum

  # defp do_decode(<<char1::binary-1>> <> rest, number, accum)
  #      when char1 in ~w(1 2 3 4 5 6 7 8 9) do
  #   do_decode(rest, number <> char1, accum)
  # end

  # defp do_decode(<<char1::binary-1>> <> rest, number, accum) do
  #   cant_to_repeat =
  #     case Integer.parse(number) do
  #       {num, _rest} -> num
  #       _ -> 1
  #     end

  #   letters = String.duplicate(char1, cant_to_repeat)

  #   do_decode(rest, "", accum <> letters)
  # end
end
