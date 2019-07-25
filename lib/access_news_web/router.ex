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

    # TODO:
    # Half  of "/users"  (see UserController)  needs auth.
    # Leave it as  it is, or split it here  in the Router?
    # :show and  :index can  go under "/manage"  anyway as
    # basically  it  is  an  admin  thing.  Or  create  an
    # "/admin" scope for admin stuff?

    resources "/users",    UserController,    only: [:index, :show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  # TODO:
  # route to login page (that has a "register" button as
  # well) for all anon visits to pages that require auth

  scope "/manage", AccessNewsWeb do
    pipe_through [:browser, :authenticate_user]

    resources "/recordings", RecordingController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AccessNewsWeb do
  #   pipe_through :api
  # end
end
