defmodule Bowling do
  @type t :: %__MODULE__{
          frame: integer(),
          frame_points: integer(),
          balls_bowled: integer(),
          score: integer(),
          bonus_scores: [integer()]
        }

  defstruct [:frame, :frame_points, :balls_bowled, :score, :bonus_scores]

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start do
    %Bowling{frame: 1, frame_points: 0, balls_bowled: 0, score: 0, bonus_scores: []}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t()
  def roll(_, points) when points < 0, do: {:error, "Negative roll is invalid"}

  def roll(%{frame_points: frame_points}, points) when points + frame_points > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  def roll(%{frame: frame, bonus_scores: []}, _) when frame > 10 do
    {:error, "Cannot roll after game is over"}
  end

  def roll(game, points) do
    game
    |> carryover_points(points)
    |> increment_points(points)
    |> bonus_scores(points)
    |> increment_frame()
  end

  # For strikes and spares
  defp carryover_points(%{bonus_scores: []} = game, _), do: game

  defp carryover_points(
         %{bonus_scores: [bonus | remaining_bonus], score: score} = game,
         points
       ) do
    %{game | score: score + points * bonus, bonus_scores: remaining_bonus}
  end

  # Only bonus points after 10th frame
  defp increment_points(%{frame: frame, frame_points: frame_points} = game, points)
       when frame > 10 do
    %{game | frame_points: frame_points + points}
  end

  defp increment_points(%{frame_points: frame_points, score: score} = game, points) do
    %{game | frame_points: frame_points + points, score: score + points}
  end

  # Strike
  defp bonus_scores(%{frame: frame, bonus_scores: [bonus]} = game, 10) when frame < 11 do
    %{game | bonus_scores: [bonus + 1, 1]}
  end

  defp bonus_scores(%{frame: frame} = game, 10) when frame < 11 do
    %{game | bonus_scores: [1, 1]}
  end

  # Points or spare
  defp bonus_scores(
         %{frame: frame, bonus_scores: bonus_scores, frame_points: 10, balls_bowled: 1} = game,
         _
       )
       when frame < 11 do
    %{game | bonus_scores: [1 | bonus_scores]}
  end

  defp bonus_scores(game, _) do
    game
  end

  defp increment_frame(%{frame: frame, balls_bowled: 1} = game) do
    %{game | frame: frame + 1, balls_bowled: 0, frame_points: 0}
  end

  # Spare or strike carry over roll
  defp increment_frame(%{frame: frame, frame_points: 10} = game) do
    %{game | frame: frame + 1, balls_bowled: 0, frame_points: 0}
  end

  # First bowl of frame, so don't increment yet
  defp increment_frame(%{balls_bowled: 0} = game) do
    %{game | balls_bowled: 1}
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t()
  def score(%{frame: frame, bonus_scores: bonus_scores}) when frame < 11 or bonus_scores != [] do
    {:error, "Score cannot be taken until the end of the game"}
  end

  def score(%{score: score}), do: score
end
