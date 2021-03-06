defmodule TaskApiWeb.Router do
  use TaskApiWeb, :router

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

  pipeline :auth_api do
    plug TaskApiWeb.Auth.Pipeline
  end

  scope "/", TaskApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TaskApiWeb do
    pipe_through :api

    scope "/users" do
      post "/register", UserController, :create
      post "/login", UserController, :login
    end

    pipe_through [:auth_api]

    scope "/tasks" do
      post "/create", TaskController, :create
      put "/:id/update", TaskController, :update
      delete "/:id", TaskController, :delete
      get "/", TaskController, :index
      get "/:id", TaskController, :show
      post "/reorder", TaskController, :reorder
    end

    # resources "/tasks", TaskController, except: [:new, :edit]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TaskApiWeb.Telemetry
    end
  end
end
