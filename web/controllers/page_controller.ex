defmodule SimpleForum.PageController do
  use SimpleForum.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
