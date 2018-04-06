defmodule MyClusterWeb.Router do
  use MyClusterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyClusterWeb do
    pipe_through :api
    get "/", ApiController, :info
    get "/join", ApiController, :join_room
  end

end
