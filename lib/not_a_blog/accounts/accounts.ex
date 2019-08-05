defmodule NotABlog.Accounts do
  import Ecto.Query, warn: false

  alias NotABlog.Repo
  alias NotABlog.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def create_user(attributes \\ %{}) do
    %User{}
    |> User.auth_changeset(attributes)
    |> Repo.insert()
  end

  def get_user(id) do
    User
    |> Repo.get(id)
  end

  def change_user_registration(%User{} = user) do
    User.auth_changeset(user, %{})
  end
end
