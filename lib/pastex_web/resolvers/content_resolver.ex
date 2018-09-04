defmodule PastexWeb.ContentResolver do
  alias Pastex.Content
  alias Absinthe.Relay

  def paste(_, %{id: id}, %{context: context}) do
    {:ok, Content.get_paste(context[:current_user], id)}
  end

  def pastes(_, pagination_args, %{context: context}) do
    pastes_connection =
      context[:current_user]
      |> Content.authorized_pastes()
      |> Relay.Connection.from_query(&Pastex.Repo.all/1, pagination_args, max: 25)

    {:ok, pastes_connection}
  end

  def search(_, _, %{context: context}) do
    {:ok, Content.list_pastes(context[:current_user])}
  end
end
