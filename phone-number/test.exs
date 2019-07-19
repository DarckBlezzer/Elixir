defmodule Test do
  def check_number("1" <> <<code::binary-3>> <> <<rest::binary-10>>) do
    code <> rest
  end

  def check_number(
        "1" <> <<code::binary-3>> <> <<start_exchange_code::binary-1>> <> <<rest::binary-5>>
      )
      when start_exchange_code not in ["0", "1"] do
    code <> start_exchange_code <> rest
  end

  def check_number(
        <<first_char_area_code::binary-1>> <>
          <<rest_area_code::binary-2>> <> <<start_exchange_code::binary-1>> <> <<rest::binary-6>>
      )
      when first_char_area_code not in ["0", "1"] and start_exchange_code not in ["0", "1"] do
    first_char_area_code <> rest
  end

  def check_number(_number), do: @bad_number
end
