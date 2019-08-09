defmodule NotABlogWeb.UserController do
  use NotABlogWeb, :controller

  alias NotABlog.Repo
  alias NotABlog.Accounts.User

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "edit.html", user: user, changeset: User.changeset(user, %{}))
  end

  def reset_password(conn, %{"id" => id}) do
    render(conn, "reset_password.html", user_id: id, changeset: User.reset_password_changeset(%User{}, %{}))
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Account settings successfully updated")
        |> redirect(to: user_path(conn, :edit, user.id))
      {:error, changeset} -> render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def update_password(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.reset_password_changeset(user, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Password was successfully updated")
        |> redirect(to: user_path(conn, :edit, user.id))
      {:error, changeset} -> render(conn, "reset_password.html", user_id: user.id, changeset: changeset)
    end
  end
end
