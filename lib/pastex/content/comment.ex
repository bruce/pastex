defmodule Pastex.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    belongs_to :paste, Pastex.Content.Paste
    field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
