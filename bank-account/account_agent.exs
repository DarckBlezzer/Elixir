defmodule BankAccount do
  @account_closed {:error, :account_closed}

  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    Agent.start(fn -> %{balance: 0} end) |> elem(1)
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(pid) do
    execute(pid, &Agent.stop(&1))
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(pid) do
    execute(pid, &Agent.get(&1, fn map -> map[:balance] end))
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(pid, amount) do
    execute(pid, &Agent.update(&1, fn map -> %{map | balance: map.balance + amount} end))
  end

  defp execute(pid, f) do
    if Process.alive?(pid) do
      f.(pid)
    else
      @account_closed
    end
  end
end
