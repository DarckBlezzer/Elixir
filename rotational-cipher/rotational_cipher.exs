defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"

  iex>RotationalCipher.rotate("Nggnpx ng qnja", 13)
  "Attack at dawn"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    do_rotate_characters(text, shift)
  end

  defp do_rotate_characters("", _shift), do: ""

  defp do_rotate_characters(<<first_char>> <> remaining_char, shift)
       when first_char in ?a..?z do
    <<rotation_char(first_char, shift, ?a)>> <> do_rotate_characters(remaining_char, shift)
  end

  defp do_rotate_characters(<<first_char>> <> remaining_char, shift)
       when first_char in ?A..?Z do
    <<rotation_char(first_char, shift, ?A)>> <> do_rotate_characters(remaining_char, shift)
  end

  defp do_rotate_characters(<<first_char>> <> remaining_char, shift),
    do: <<first_char>> <> do_rotate_characters(remaining_char, shift)

  defp rotation_char(first_char, shift, starter),
    do: rem(first_char - starter + shift, 26) + starter
end

# RotationalCipher.rotate("The quick brown fox jumps over the lazy dog.", 13)
# |> IO.inspect()

# RotationalCipher.rotate("Gur dhvpx oebja sbk whzcf bire gur ynml qbt.", 13)
# |> IO.inspect()
