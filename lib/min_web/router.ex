defmodule MinWeb.Router do
  use MinWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MinWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/:hash", LinkController, :show
  end

  # Other scopes may use custom stacks.
  scope "/api", MinWeb do
    pipe_through :api
    post "/links", LinkController, :create
  end
end
