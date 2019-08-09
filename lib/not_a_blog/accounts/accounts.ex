defmodule NotABlog.Accounts do
  import Ecto.Query, warn: false

  alias NotABlog.Repo
  alias NotABlog.Accounts.User

  def list_users do
    Repo.all(User)
  end
end
