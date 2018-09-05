defmodule Pastex.Repo.Migrations.CreatePastes do
  use Ecto.Migration

  def change do
    create table(:pastes) do
      add :name, :string
      add :description, :text
      add :author_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:pastes, [:author_id])
  end
end
