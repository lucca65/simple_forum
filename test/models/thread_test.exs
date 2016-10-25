defmodule SimpleForum.ThreadTest do
  use SimpleForum.ModelCase

  alias SimpleForum.Thread

  @valid_attrs %{author_email: "some content", body: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Thread.changeset(%Thread{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Thread.changeset(%Thread{}, @invalid_attrs)
    refute changeset.valid?
  end
end
