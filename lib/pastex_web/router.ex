defmodule PastexWeb.Router do
  use PastexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PastexWeb do
    pipe_through :api
  end
end
