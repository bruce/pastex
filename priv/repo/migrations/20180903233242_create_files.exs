defmodule Pastex.Repo.Migrations.CreateFiles do
  use Ecto.Migration

  def change do
    create table(:files) do
      add :name, :string
      add :body, :text
      add :paste_id, references(:pastes, on_delete: :nothing)

      timestamps()
    end

    create index(:files, [:paste_id])
  end
end
