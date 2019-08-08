defmodule NotABlogWeb.SessionController do
  use NotABlogWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
    case NotABlog.Auth.authenticate_user(name, password) do
      {:ok, name} ->
        conn
        |> NotABlog.Auth.login(name)
        |> put_flash(:info, "Welcome!")
        |> redirect(to: post_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> NotABlog.Auth.logout
    |> put_flash(:info, "Good bye")
    |> redirect(to: session_path(conn, :new))
  end
end
