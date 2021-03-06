defmodule Min.Repo.Migrations.Init do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :hash, :string, null: false
      add :url, :string, null: false
      timestamps()
    end

    create unique_index(:links, [:hash])
  end
end
