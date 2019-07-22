defmodule AccessNewsWeb.Router do
  use AccessNewsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug AccessNewsWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AccessNewsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", AccessNewsWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/recordings", RecordingController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AccessNewsWeb do
  #   pipe_through :api
  # end
end
