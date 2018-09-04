defmodule PastexWeb.Schema do
  use Absinthe.Schema

  import_types __MODULE__.ContentTypes

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    import_fields :content_queries
  end
end
