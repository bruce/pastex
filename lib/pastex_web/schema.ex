defmodule PastexWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Relay.Schema, :modern

  import_types PastexWeb.Schema.{ContentTypes, IdentityTypes}

  query do
    field :health, :string do
      resolve(fn _, _, _ ->
        {:ok, "up"}
      end)
    end

    import_fields :identity_queries
    import_fields :content_queries
  end

  mutation do
    import_fields :identity_mutations
    import_fields :content_mutations
  end

  subscription do
    field :paste_created, :paste do
      arg :visibility, :string, default_value: "public"

      config fn %{visibility: visibility}, %{context: context} ->
        context |> IO.inspect()

        case {visibility, context} do
          {"public", _} ->
            {:ok, topic: "public"}

          {"private", %{current_user: %{id: user_id}}} ->
            {:ok, topic: "private:#{user_id}"}

          _ ->
            {:error, "unauthorized"}
        end
      end

      trigger :create_paste,
        topic: fn paste ->
          if paste.visibility == "public" do
            ["public"]
          else
            ["private:#{paste.author_id}"]
          end
        end
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(:content, Pastex.Content.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  alias PastexWeb.Middleware

  def middleware(middleware, _, _) do
    tracing_middleware() ++ [Middleware.AuthGet | middleware]
  end

  defp tracing_middleware() do
    [ApolloTracing.Middleware.Tracing]
  end
end
