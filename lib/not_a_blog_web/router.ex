defmodule NotABlogWeb.Router do
  use NotABlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authentication_check do
    plug NotABlog.Auth.AuthAccessPipeline
  end

  scope "/", NotABlogWeb do
    pipe_through [:browser]

    resources("/sessions", SessionController, only: [:new, :create, :delete])

    scope "/posts" do
      pipe_through :authentication_check
      resources "/", PostController, except: [:index, :show]
    end

    scope "/posts" do
      resources("/", PostController, only: [:index, :show])
    end
  end
end
