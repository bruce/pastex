defmodule PastexWeb.Router do
  use PastexWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(PastexWeb.Context)
  end

  scope "/" do
    pipe_through(:api)

    forward("/api", Absinthe.Plug,
      schema: PastexWeb.Schema,
      pipeline: {ApolloTracing.Pipeline, :plug}
    )

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: PastexWeb.Schema,
      interface: :playground,
      socket: PastexWeb.UserSocket,
      pipeline: {ApolloTracing.Pipeline, :plug},
      analyze_complexity: true,
      max_complexity: 1_000
    )
  end
end
