defmodule PastexWeb.Middleware.AuthGet do
  @behaviour Absinthe.Middleware

  alias Pastex.Identity

  def call(resolution, _) do
    entity = resolution.source
    key = resolution.definition.schema_node.identifier
    current_user = resolution.context[:current_user]

    if Identity.authorized?(entity, key, current_user) do
      resolution
    else
      Absinthe.Resolution.put_result(resolution, {:error, "unauthorized"})
    end
  end
end
