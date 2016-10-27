defmodule SimpleForum.Storage do
  @doc """
  Rewarder Storage is a simple Agent (wrapper for state management) that only holds a list of words
  """
  def start_link do
    Agent.start_link(fn -> [] end)
  end

  @doc """
  Get all words, but filters the repeated ones.
  """
  def get(words_pid) do
    Agent.get(words_pid, &(&1)) # `&(&1)` is a shorthand for `fn x -> x end`
    |> Enum.uniq
  end

  @doc """
  Add an words
  """
  def put(words_pid, word) do
    Agent.update(words_pid, &(&1 ++ [word]))
  end
end
