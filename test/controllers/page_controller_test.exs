defmodule SimpleForum.PageControllerTest do
  use SimpleForum.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Listing threads"
  end
end
