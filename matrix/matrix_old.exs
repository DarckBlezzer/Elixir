defmodule Matrix do
  defstruct rows: %{}, columns: %{}

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    # String.split(input, "\n")
    # |> Enum.map(fn list ->
    #   Enum.map(String.split(list, " "), &String.to_integer(&1))
    # end)

    do_matrix(input)
  end

  defp do_matrix(input, x \\ 0, y \\ 0, matrix \\ %Matrix{}, accum \\ "")

  defp do_matrix("", x, y, matrix, accum) do
    put_in_matrix(accum, x, y, matrix)
  end

  defp do_matrix("\n" <> rest, x, y, matrix, accum) do
    new_matrix = put_in_matrix(accum, x, y, matrix)
    do_matrix(rest, 0, y + 1, new_matrix, "")
  end

  defp do_matrix(" " <> rest, x, y, matrix, accum) do
    new_matrix = put_in_matrix(accum, x, y, matrix)
    do_matrix(rest, x + 1, y, new_matrix, "")
  end

  defp do_matrix(<<char::binary-1>> <> rest, x, y, matrix, accum) do
    do_matrix(rest, x, y, matrix, accum <> char)
  end

  defp put_in_matrix(number, x, y, matrix) do
    number = String.to_integer(number)
    {_old_matrix, matrix} = Map.get_and_update(matrix, :rows, &{&1, Map.put(&1, {x, y}, number)})

    {_old_matrix, matrix} =
      Map.get_and_update(matrix, :columns, &{&1, Map.put(&1, {y, x}, number)})

    matrix
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{rows: matrix}) do
    # Enum.map_join(matrix[:matrix], "\n", &Enum.join(&1, " "))

    do_transform_to_string(matrix)
    |> String.replace(" \n", "\n")
    |> String.trim()
  end

  defp do_transform_to_string(matrix, x \\ 0, y \\ 0)

  defp do_transform_to_string(matrix, x, y) do
    cond do
      (result = Map.get(matrix, {x, y}, nil)) != nil ->
        "#{result} " <> do_transform_to_string(matrix, x + 1, y)

      Map.get(matrix, {0, y + 1}, nil) != nil ->
        "\n" <> do_transform_to_string(matrix, 0, y + 1)

      true ->
        ""
    end
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{rows: matrix}) do
    {{max_rows, _}, _} = Enum.max_by(matrix, &elem(&1, 0))

    do_get_rows(matrix, 0, max_rows)
  end

  defp do_get_rows(matrix, x, max_rows) when x <= max_rows do
    row =
      Stream.iterate(0, &(&1 + 1))
      |> Stream.map(&Map.get(matrix, {&1, x}))
      |> Enum.take_while(&(&1 != nil))

    [row | do_get_rows(matrix, x + 1, max_rows)]
  end

  defp do_get_rows(_matrix, _x, _max_rows), do: []

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Enum.at(rows(matrix), index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{columns: matrix}) do
    {{max_columns, _}, _} = Enum.max_by(matrix, &elem(&1, 0))

    do_get_columns(matrix, 0, max_columns)
  end

  defp do_get_columns(matrix, x, max_columns) when x <= max_columns do
    row =
      Stream.iterate(0, &(&1 + 1))
      |> Stream.map(&Map.get(matrix, {&1, x}))
      |> Enum.take_while(&(&1 != nil))

    [row | do_get_columns(matrix, x + 1, max_columns)]
  end

  defp do_get_columns(_matrix, _x, _max_columns), do: []

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    Enum.at(columns(matrix), index)
  end
end
