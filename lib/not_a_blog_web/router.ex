defmodule NotABlogWeb.Router do
  use NotABlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug(NotABlog.Auth.AuthAccessPipeline)
  end

  scope "/", NotABlogWeb do
    pipe_through [:browser]

    resources("/sessions", SessionController)
    resources("/posts", PostController)
  end
end
