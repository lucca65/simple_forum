defmodule SimpleForum.ThreadControllerTest do
  use SimpleForum.ConnCase

  alias SimpleForum.Thread
  @valid_attrs %{author_email: "some content", body: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, thread_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing threads"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, thread_path(conn, :new)
    assert html_response(conn, 200) =~ "New thread"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, thread_path(conn, :create), thread: @valid_attrs
    assert redirected_to(conn) == thread_path(conn, :index)
    assert Repo.get_by(Thread, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, thread_path(conn, :create), thread: @invalid_attrs
    assert html_response(conn, 200) =~ "New thread"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, thread_path(conn, :show, -1)
    end
  end

  # this forum includes no edits or deletes

  # test "renders form for editing chosen resource", %{conn: conn} do
  #   thread = Repo.insert! %Thread{}
  #   conn = get conn, thread_path(conn, :edit, thread)
  #   assert html_response(conn, 200) =~ "Edit thread"
  # end

  # test "updates chosen resource and redirects when data is valid", %{conn: conn} do
  #   thread = Repo.insert! %Thread{}
  #   conn = put conn, thread_path(conn, :update, thread), thread: @valid_attrs
  #   assert redirected_to(conn) == thread_path(conn, :show, thread)
  #   assert Repo.get_by(Thread, @valid_attrs)
  # end

  # test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
  #   thread = Repo.insert! %Thread{}
  #   conn = put conn, thread_path(conn, :update, thread), thread: @invalid_attrs
  #   assert html_response(conn, 200) =~ "Edit thread"
  # end

  # test "deletes chosen resource", %{conn: conn} do
  #   thread = Repo.insert! %Thread{}
  #   conn = delete conn, thread_path(conn, :delete, thread)
  #   assert redirected_to(conn) == thread_path(conn, :index)
  #   refute Repo.get(Thread, thread.id)
  # end
end
