defmodule NotABlogWeb.StaticPageController do
  use NotABlogWeb, :controller

  def forgot_password(conn, _params) do
    render(conn, "forgot_password.html")
  end
end
