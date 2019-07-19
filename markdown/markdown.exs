defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  @spec parse(String.t()) :: String.t()
  def parse(m) do
    String.split(m, "\n")
    |> Enum.map_join(&do_match/1)
    |> replace_md
  end

  defp do_match("#" <> rest), do: do_count_header(rest, 1)
  defp do_match("* " <> rest), do: "<li>#{rest}</li>"
  defp do_match("*" <> rest), do: "<li>#{rest}</li>"
  defp do_match(prase), do: "<p>#{prase}</p>"

  defp do_count_header("#" <> rest, acc), do: do_count_header(rest, acc + 1)
  defp do_count_header(" " <> rest, acc), do: "<h#{acc}>#{rest}</h#{acc}>"
  defp do_count_header(prase, acc), do: "<h#{acc}>#{prase}</h#{acc}>"

  defp replace_md(prase) do
    String.replace(prase, ~r/__(.*)__/, "<strong>\\1</strong>")
    |> String.replace(~r/_(.*)_/, "<em>\\1</em>")
    |> String.replace(~r/<li>(.*)<\/li>/, "<ul>\\0</ul>")
  end
end

Markdown.parse("##Header!\n* __Bold Item__\n* _Italic Item_")
|> IO.inspect()
