defmodule NotABlog.Auth.AuthErrorHandler do
  use NotABlogWeb, :controller

  def auth_error(conn, _info, _options) do
    conn
    |> put_flash(:error, "You need to log in")
    |> put_view(NotABlogWeb.SessionView)
    |> render("new.html", layout: {NotABlogWeb.LayoutView, "app.html"})
  end
end
