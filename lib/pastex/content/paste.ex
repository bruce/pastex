defmodule Pastex.Content.Paste do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pastes" do
    field :description, :string
    field :name, :string
    field :author_id, :id

    has_many :files, Pastex.Content.File

    timestamps()
  end

  @doc false
  def changeset(paste, attrs) do
    paste
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
