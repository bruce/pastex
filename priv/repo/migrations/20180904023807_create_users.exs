defmodule Pastex.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:name, :string, null: false)

      timestamps()
    end
  end
end
