defmodule Pastex.Content.File do
  use Ecto.Schema
  import Ecto.Changeset


  schema "files" do
    field :body, :string
    field :name, :string
    field :paste_id, :id

    timestamps()
  end

  @doc false
  def changeset(file, attrs) do
    file
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
