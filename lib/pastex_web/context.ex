defmodule PastexWeb.Context do
  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- Plug.Conn.get_req_header(conn, "authorization"),
         {:ok, user_id} <- PastexWeb.Auth.verify(token),
         %{} = user <- Pastex.Identity.get_user(user_id) do
      %{current_user: user}
    else
      _ -> %{}
    end
  end
end
