defmodule SimpleForum.Blacklist do
  def filter(text) do
    clear_all(text, blacklist())
  end

  def clear_all(text, []), do: text
  def clear_all(text, [dark_word|rest]) do
    hide_word(text, dark_word)
    |> clear_all(rest)
  end

  def blacklist do
    :global.whereis_name(:storage)
    |> SimpleForum.Storage.get
  end

  def hide_word(text, dark_word) do
    text
    |> String.replace(dark_word, to_asterisk(dark_word), global: true)
  end

  def to_asterisk(word) do
    word
    |> String.codepoints
    |> Enum.map(fn _ -> "*" end)
    |> Enum.join
  end
end
