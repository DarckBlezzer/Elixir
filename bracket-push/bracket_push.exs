defmodule BracketPush do
  @brackets [
    {"(", ")"},
    {"{", "}"},
    {"[", "]"}
  ]

  @start_brackets ~w/( { [/
  @end_brackets ~w/) } ]/
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    do_check_brackets?(str, [])
  end

  defp do_check_brackets?("", []), do: true
  defp do_check_brackets?("", order_list) when length(order_list) > 0, do: false

  defp do_check_brackets?(<<char::binary-1>> <> rest, order_list) when char in @start_brackets,
    do: do_check_brackets?(rest, [get_brackets(char) | order_list])

  defp do_check_brackets?(<<char::binary-1>> <> rest, [{_h, t} | tail]) when char == t,
    do: do_check_brackets?(rest, tail)

  defp do_check_brackets?(<<char::binary-1>> <> _rest, [{_h, t} | _tail])
       when char in @end_brackets and char != t,
       do: false

  defp do_check_brackets?(<<_char::binary-1>> <> rest, order_list),
    do: do_check_brackets?(rest, order_list)

  defp get_brackets(char), do: Enum.find(@brackets, &(elem(&1, 0) == char))
  # defp is_end_bracket?(char), do: Enum.find(@brackets, &(elem(&1, 1) == char))
end
