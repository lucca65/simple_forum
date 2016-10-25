defmodule SimpleForum.Thread do
  use SimpleForum.Web, :model

  import Ecto.Query

  alias SimpleForum.Repo
  alias SimpleForum.Thread

  schema "threads" do
    field :title, :string
    field :author_email, :string
    field :body, :string
    belongs_to :parent, SimpleForum.Thread
    has_many :comments, SimpleForum.Thread, foreign_key: :parent_id

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :author_email, :body, :parent_id])
    |> validate_required([:title, :author_email, :body])
  end

  @doc """
  Find Threads that were created today
  """
  def created_today do
    today = Timex.now |> Timex.beginning_of_day()
    today_end = Timex.now |> Timex.end_of_day()

    q = from t in Thread,
      where: t.inserted_at >= ^today and t.inserted_at <= ^today_end,
      select: t

    q |> Repo.all()
  end

  @doc """
  Find root thread based on parent
  """
  def root(thread = %{parent_id: nil}), do: thread
  def root(thread) do
    thread
    |> Repo.preload(:parent)
    |> Map.get(:parent)
    |> root
  end


  @def """
  Tree all threads into a multi-depth list
  """
  def thread_tree(thread, threads \\ [])
  def thread_tree(thread, []), do: thread_tree(thread, [thread])
  def thread_tree(nil, threads), do: threads
  def thread_tree(thread, threads) do
    thread = thread |> Repo.preload(:comments)


    if thread.comments |> Enum.any? do
      thread.comments |> Enum.map(fn comment ->
        thread_tree(comment, threads ++ thread.comments)
      end)
    else
      thread_tree(nil, threads ++ [thread])
    end
  end
end
