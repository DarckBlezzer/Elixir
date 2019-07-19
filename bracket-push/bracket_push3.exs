defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    check_brackets(str, [])
  end

  # string ran out, stack empty
  defp check_brackets("", []), do: true

  # string ran out, stack not empty
  defp check_brackets("", _stack), do: false

  # match opening brackets, add to stack
  defp check_brackets(<<char::binary-1>> <> rest, stack) when char in ~w/[ ( {/,
    do: check_brackets(rest, [char | stack])

  # match closing brackets, remove matching opening bracket from stack
  defp check_brackets("]" <> rest, ["[" | stack]), do: check_brackets(rest, stack)
  defp check_brackets(")" <> rest, ["(" | stack]), do: check_brackets(rest, stack)
  defp check_brackets("}" <> rest, ["{" | stack]), do: check_brackets(rest, stack)

  # match closing bracket without matching opening bracket on stack
  defp check_brackets(<<char::binary-1>> <> _rest, _stack) when char in ~w/] ) }/, do: false

  # ignore non-bracket character
  defp check_brackets(<<_char::binary-1>> <> rest, stack), do: check_brackets(rest, stack)
end
