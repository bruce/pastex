defmodule PastexWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types(__MODULE__.ContentTypes)
  import_types(__MODULE__.IdentityTypes)

  query do
    import_fields :content_queries
  end
end
