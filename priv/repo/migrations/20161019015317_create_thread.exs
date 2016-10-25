defmodule SimpleForum.Repo.Migrations.CreateThread do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :title, :string
      add :author_email, :string
      add :body, :text
      add :parent_id, references(:threads, on_delete: :nothing)

      timestamps()
    end
    create index(:threads, [:parent_id])

  end
end
