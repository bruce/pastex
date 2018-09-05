defmodule PastexWeb.Auth do
  @user_salt "user salt"

  def sign(data) do
    Phoenix.Token.sign(PastexWeb.Endpoint, @user_salt, data)
  end

  def verify(token) do
    Phoenix.Token.verify(PastexWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end
end
