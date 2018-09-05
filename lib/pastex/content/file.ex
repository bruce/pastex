defmodule Pastex.Content.File do
  use Ecto.Schema
  import Ecto.Changeset

  schema "files" do
    field :body, :string
    field :name, :string
    belongs_to :paste, Pastex.Content.Paste

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
