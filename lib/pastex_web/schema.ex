defmodule PastexWeb.Schema do
  use Absinthe.Schema

  import_types(__MODULE__.ContentTypes)
  import_types(__MODULE__.IdentityTypes)

  query do
  end
end
