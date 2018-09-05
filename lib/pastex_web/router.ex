defmodule PastexWeb.Router do
  use PastexWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    plug(PastexWeb.Context)
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: PastexWeb.Schema,
      interface: :playground,
      socket: PastexWeb.UserSocket,
      pipeline: {ApolloTracing.Pipeline, :plug},
      analyze_complexity: true,
      max_complexity: 10_000
    )
  end
end
