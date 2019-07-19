defmodule Meetup do
  @day_ranges %{
    :first => 1,
    :second => 8,
    :third => 15,
    :fourth => 22,
    :last => 6,
    :teenth => 13
  }

  @weekdays %{
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6,
    :sunday => 7
  }

  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    create_date_tuple(year, month, schedule)
    |> Stream.iterate(fn {y, m, d} -> {y, m, d + 1} end)
    |> Enum.find(nil, &(:calendar.day_of_the_week(&1) == @weekdays[weekday]))
  end

  def create_date_tuple(year, month, :last) do
    day = :calendar.last_day_of_the_month(year, month) - @day_ranges[:last]
    {year, month, day}
  end

  def create_date_tuple(year, month, schedule), do: {year, month, @day_ranges[schedule]}
end
