defmodule PastexWeb.Schema do
  use Absinthe.Schema

  alias PastexWeb.ContentResolver

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    field :pastes, list_of(:paste) do
      resolve &ContentResolver.pastes/3
    end
  end

  object :paste do
    field :name, non_null(:string)
    field :description, :string

    field :files, non_null(list_of(:file)) do
      resolve &ContentResolver.get_files/3
    end
  end

  object :file do
    field :paste, non_null(:paste)

    field :name, :string do
      resolve fn file, _, _ ->
        {:ok, Map.get(file, :name) || "Untitled"}
      end
    end

    field :body, :string
  end
end
