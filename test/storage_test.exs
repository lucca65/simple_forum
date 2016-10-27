defmodule SimpleForum.StorageTest do
  use ExUnit.Case, async: true
  alias SimpleForum.Storage

  setup do
    # Create a new link with the state manager
    # Note that `storage_pid` is the Process ID to storage
    {:ok, storage_pid} = Storage.start_link

    # Function return is like that to match ExUnit `test` macro
    {:ok, storage: storage_pid}
  end

  test "store stuff", %{storage: storage} do
    # makes sure it starts empty
    # Uses `Storage.get/1` because it is a Agent (simple wrapper for state)
    assert Storage.get(storage) == []

    # puts some storage on the list
    Storage.put(storage, {1, 2})
    assert Storage.get(storage) == [{1,2}]
  end

  test "makes sure repeated storage don't enter list", %{storage: storage} do
    Storage.put(storage, {1,2})
    Storage.put(storage, {1,2})

    assert Storage.get(storage) == [{1,2}]
  end
end
