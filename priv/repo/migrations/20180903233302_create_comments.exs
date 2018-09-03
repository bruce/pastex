defmodule Pastex.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:body, :text)
      add(:paste_id, references(:pastes, on_delete: :nothing))
      add(:author_id, references(:users, on_delete: :nothing))

      timestamps()
    end

    create(index(:comments, [:paste_id]))
    create(index(:comments, [:author_id]))
  end
end
