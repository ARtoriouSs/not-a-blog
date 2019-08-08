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
    Repo.get(User,id)
  end
end
