defmodule PastexWeb.Schema do
  use Absinthe.Schema

  import_types PastexWeb.Schema.ContentTypes

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    import_fields :content_queries
  end

  mutation do
    import_fields :content_mutations
  end

  subscription do
    field :paste_change, :paste do
      config fn _, _ ->
        {:ok, topic: "all"}
      end

      trigger [:create_paste],
        topic: fn paste ->
          [paste.id, "all"]
        end
    end
  end
end
