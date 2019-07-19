defmodule Phone do
  @bad_number "0000000000"
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    raw = String.replace(raw, ~r/[\(\)\-\.\+ ]/, "")

    cond do
      String.length(raw) > 11 or String.length(raw) < 10 ->
        @bad_number

      raw =~ ~r/[^\(\)\-\.\+ 0-9]/ ->
        @bad_number

      String.length(raw) == 11 and not String.starts_with?(raw, "1") ->
        @bad_number

      String.length(raw) == 11 and String.at(raw, 4) in ["0", "1"] ->
        @bad_number

      String.length(raw) == 10 and String.starts_with?(raw, ["0", "1"]) ->
        @bad_number

      String.length(raw) == 10 and String.at(raw, 3) in ["0", "1"] ->
        @bad_number

      String.length(raw) == 11 ->
        String.slice(raw, 1..-1)

      true ->
        raw
    end

    # Second try, not like it
    # if raw =~ ~r/[^\(\)\-\.\+ 0-9]/ do
    #   @bad_number
    # else
    #   check_number(raw)
    # end
  end

  # Not like for complexity and undestand for others
  # def check_number("1" <> <<code::binary-3>> <> <<rest::binary-7>>) do
  #   code <> rest
  # end

  # def check_number(
  #       "1" <> <<code::binary-3>> <> <<start_exchange_code::binary-1>> <> <<rest::binary-6>>
  #     )
  #     when start_exchange_code not in ["0", "1"] do
  #   code <> start_exchange_code <> rest
  # end

  # def check_number(
  #       <<first_char_area_code::binary-1>> <>
  #         <<rest_area_code::binary-2>> <> <<start_exchange_code::binary-1>> <> <<rest::binary-6>>
  #     )
  #     when first_char_area_code not in ["0", "1"] and start_exchange_code not in ["0", "1"] do
  #   first_char_area_code <> rest_area_code <> start_exchange_code <> rest
  # end

  # def check_number(_number), do: @bad_number

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    <<area_code::binary-3>> <> _num = number(raw)
    area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    <<area_code::binary-3>> <> <<exchange::binary-3>> <> <<line_number::binary-4>> = number(raw)

    "(#{area_code}) #{exchange}-#{line_number}"
  end
end
