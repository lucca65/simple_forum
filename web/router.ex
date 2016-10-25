defmodule SimpleForum.Router do
  use SimpleForum.Web, :router

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

  scope "/", SimpleForum do
    pipe_through :browser # Use the default browser stack

    get "/", ThreadController, :index
    resources "/threads", ThreadController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleForum do
  #   pipe_through :api
  # end
end
