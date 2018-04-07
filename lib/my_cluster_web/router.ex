defmodule MyClusterWeb.Router do
  use MyClusterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MyClusterWeb do
    pipe_through :api
    get "/", ApiController, :info
    post "/:room/join/:nickname", ApiController, :join_room
    get "/:room/list_members", ApiController, :list_members
  end
end
