defmodule NotABlogWeb.PostController do
  use NotABlogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
