defmodule Pastex.Repo.Migrations.AddVisibilityToPaste do
  use Ecto.Migration

  def change do
    alter table(:pastes) do
      add(:visibility, :string, null: false, default: "public")
    end
  end
end
