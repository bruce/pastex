defmodule PastexWeb.Schema.IdentityTypes do
  use Absinthe.Schema.Notation

  alias Pastex.Identity

  object :identity_mutations do
    field :create_session, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &create_session/3
    end
  end

  def create_session(_, %{email: email, password: password}, _) do
    case Identity.authenticate(email, password) do
      {:ok, user} ->
        session = %{
          token: PastexWeb.Auth.sign(user.id),
          user: user
        }

        {:ok, session}

      error ->
        error
    end
  end

  object :session do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end

  object :user do
    field :name, :string
    field :email, :string
  end
end
