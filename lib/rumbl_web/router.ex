defmodule RumblWeb.Router do
  use RumblWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Rumbl.Auth, repo: Rumbl.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RumblWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # get "/users", UserController, :index
    # get "/users/:id", UserController, :show
    # get "/users/new", UserController, :new
    #
    # get "/users/:id/edit", UserController, :edit
    # post "/users", UserController, :create
    # patch "/users/:id", UserController, :update
    # put "/users/:id", UserController, :update
    # delete "/users/:id", UserController, :delete
    resources "/users", UserController, only: [:index, :show, :new, :create, :delete]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

  end

  # Other scopes may use custom stacks.
  # scope "/api", RumblWeb do
  #   pipe_through :api
  # end
end
