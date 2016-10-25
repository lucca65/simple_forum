defmodule SimpleForum.ThreadController do
  use SimpleForum.Web, :controller

  alias SimpleForum.Thread

  @docs """
  Index just shows root threads
  """
  def index(conn, params) do
    query = from t in Thread,
      preload: :comments,
      where: is_nil(t.parent_id),
      order_by: [desc: t.inserted_at],
      select: t

    {threads, kerosene} =
      query
      |> Repo.paginate(params)
    render(conn, :index, threads: threads, kerosene: kerosene)
  end

  def new(conn, params) do
    changeset = Thread.changeset(%Thread{})

    parent_id = Map.get(params, "id")
    unless is_nil(parent_id) do
      parent = Repo.get!(Thread, parent_id)
      render(conn, "new.html", changeset: changeset, parent: parent)
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def create(conn, %{"thread" => thread_params}) do
    # require IEx; IEx.pry
    filtered_text = thread_params["body"] |> SimpleForum.Blacklist.filter()
    thread_params = %{ thread_params | "body" => filtered_text }

    changeset = Thread.changeset(%Thread{}, thread_params)

    case Repo.insert(changeset) do
      {:ok, _thread} ->
        conn
        |> put_flash(:info, "Thread created successfully.")
        |> redirect(to: thread_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    thread = Repo.get!(Thread, id) |> Repo.preload(:comments)
    render(conn, "show.html", thread: thread)
  end
end
