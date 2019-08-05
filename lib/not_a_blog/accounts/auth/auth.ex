defmodule NotABlog.Auth do
  require Ecto.Query

  import Plug.Conn

  alias NotABlog.Auth.Guardian
  alias Comeonin.Bcrypt
  alias NotABlog.Accounts.User
  alias NotABlog.Repo

  def authenticate_user(username, given_password) do
    Ecto.Query.from(user in User, where: user.name == ^username)
    |> Repo.one
    |> check_password(given_password)
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> assign(:current_user, user)
  end

  def logout(conn) do
    Guardian.Plug.sign_out(conn)
  end

  def load_current_user(conn) do
    assign(conn, :current_user, Guardian.Plug.current_resource(conn))
  end

  defp check_password(nil, _given_password), do: {:error, "Incorrect username or password"}

  defp check_password(user, given_password) do
    case Bcrypt.checkpw(given_password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Incorrect username or password"}
    end
  end
end
