defmodule SimpleForum.BlacklistTest do
  use ExUnit.Case, async: true
  alias SimpleForum.Blacklist
  alias SimpleForum.Storage

  setup do
    {:ok, pid} = Storage.start_link

    {:ok, storage: pid}
  end

  test "IO with Storage", %{storage: pid} do
    assert Storage.get(pid) == []

    pid |> Storage.put("word1")
    pid |> Storage.put("word2")
    pid |> Storage.put("word3")

    assert Storage.get(pid) == ["word1", "word2", "word3"]
  end

  test "black word substitution", %{storage: pid} do
    assert Blacklist.hide_word("a a b b", "a") == "* * b b"
  end
end
