defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  @map_characters [
    {"p",
     %{
       match: ~r/^[A-Za-z!¡¿?0-9_]/,
       end_with: ["\n"],
       html_start: "<p>",
       html_end: "</p>",
       no_inner_of: ["h", "ul", "li", "strong", "em", "c"],
       delete_first_space: true
     }},
    {"h",
     %{
       match: ~r/^#+[ A-Za-z!¡¿?0-9]/,
       end_with: ["\n"],
       html_start: "<h[NUMBER]>",
       html_end: "</h[NUMBER]>",
       count_and_replace_html: true,
       delete_char: true,
       delete_first_space: true
     }},
    {"ul",
     %{
       match: ~r/^\*/,
       end_with: ["\n", " "],
       html_start: "<ul>",
       html_end: "</ul>"
     }},
    {"li",
     %{
       match: ~r/^\*/,
       end_with: ["\n"],
       html_start: "<li>",
       html_end: "</li>",
       delete_char: true,
       delete_first_space: true
     }},
    {"strong",
     %{
       match: ~r/^__[ A-Za-z!¡¿?0-9]/,
       end_with: ["__ ", "\n", ~r/^__[A-Za-z!¡¿?0-9]{0,1}/],
       html_start: "<strong>",
       html_end: "</strong>",
       delete_char: true
     }},
    {"em",
     %{
       match: ~r/^_[ A-Za-z!¡¿?0-9]/,
       end_with: ["_ ", "\n", ~r/^_[A-Za-z!¡¿?0-9]{0,1}/],
       html_start: "<em>",
       html_end: "</em>",
       delete_char: true
     }},
    {"c",
     %{
       match: ~r/^<[ A-Za-z!¡¿?0-9]/,
       end_with: ["> ", "\n", ~r/^>[A-Za-z!¡¿?0-9]{0,1}/],
       html_start: "<code>",
       html_end: "</code>",
       delete_char: true
     }}
  ]

  @spec parse(String.t()) :: String.t()
  def parse(m) do
    do_parse(m)
  end

  defp do_parse(parse, accum \\ [], final_string \\ "")

  defp do_parse("", [], final_string), do: final_string

  defp do_parse("", [{_html_tag, map} | accum_tail], final_string) do
    do_parse("", accum_tail, final_string <> map[:html_end])
  end

  defp do_parse(prase, accum, final_string) do
    {new_prase, new_accum, new_final_string} =
      is_match?(prase, accum)
      |> do_something(final_string)

    do_parse(new_prase, new_accum, new_final_string)
  end

  defp do_something({<<h::binary-1>> <> rest, [], nil}, final_string) do
    {rest, [], final_string <> h}
  end

  defp do_something(
         {prase = <<h::binary-1>> <> rest, accum = [{_html_tag, map} | accum_tail], nil},
         final_string
       ) do
    result =
      Enum.any?(
        map[:end_with],
        fn x ->
          cond do
            (is_binary(x) or is_list(x)) and
                String.starts_with?(prase, x) ->
              true

            is_map(x) and prase =~ x ->
              true

            true ->
              false
          end
        end
      )

    if result == true do
      {new_prase, new_map} = check_delete_char({prase, map})

      {new_prase, accum_tail, final_string <> new_map[:html_end]}
    else
      {rest, accum, final_string <> h}
    end
  end

  defp do_something({prase, accum, {html_tag, map}}, final_string) do
    {new_prase, new_map} =
      check_count_and_replace_html({prase, map})
      |> check_delete_char()
      |> check_delete_first_space()

    {new_prase, [{html_tag, new_map} | accum], final_string <> new_map[:html_start]}
  end

  defp is_match?(prase, accum) do
    result = Enum.find(@map_characters, nil, &is_fine?(prase, accum, &1))

    {prase, accum, result}
  end

  defp is_fine?(prase, accum, key_list = {_html_tag, map}) do
    cond do
      map[:no_inner_of] != nil and prase =~ map[:match] and
          not Enum.any?(accum, fn sub_key_list = {html_tag, _map} ->
            html_tag in map[:no_inner_of] or sub_key_list == key_list
          end) ->
        # not Enum.any?(map[:no_inner_of], &Enum.member?(Keyword.keys(accum), &1)) and
        #   not Enum.member?(accum, key_list) ->
        true

      is_nil(map[:no_inner_of]) and prase =~ map[:match] and not Enum.member?(accum, key_list) ->
        true

      true ->
        false
    end
  end

  # --------------------------------------------

  defp check_count_and_replace_html({prase, map = %{count_and_replace_html: true}}) do
    {count, _rest} = do_count_sames_firsts(prase)
    html_start = String.replace(map[:html_start], "[NUMBER]", Integer.to_string(count))
    html_end = String.replace(map[:html_end], "[NUMBER]", Integer.to_string(count))

    new_map = %{map | html_start: html_start, html_end: html_end}

    {prase, new_map}
  end

  defp check_count_and_replace_html(prase_and_map), do: prase_and_map
  # --------------------------------------------

  defp check_delete_char({prase, map = %{delete_char: true}}) do
    rest = String.replace_leading(prase, String.first(prase), "")
    {rest, map}
  end

  defp check_delete_char(prase_and_map), do: prase_and_map

  # --------------------------------------------

  defp check_delete_first_space({" " <> rest, map = %{delete_first_space: true}}),
    do: {rest, map}

  defp check_delete_first_space({prase, map = %{delete_first_space: true}}),
    do: {prase, map}

  defp check_delete_first_space(prase_and_map), do: prase_and_map
  # --------------------------------------------------------
  defp do_count_sames_firsts(<<first_char::binary-1>> <> rest), do: count(rest, first_char)

  defp count(prase = <<first_char::binary-1>> <> rest, character, count \\ 1) do
    cond do
      first_char == character ->
        count(rest, character, count + 1)

      true ->
        {count, prase}
    end
  end
end

Markdown.parse("##Header!\n* __Bold Item__\n* _Italic Item_\n <codigo>")
|> IO.inspect()
