defmodule PastexWeb.Schema.IdentityTypes do
  use Absinthe.Schema.Notation

  object(:user) do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :pastes, non_null(list_of(:string))
  end

  object :session do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end
end
