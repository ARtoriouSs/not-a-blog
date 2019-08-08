defmodule NotABlog.Auth do
  require Ecto.Query

  import Plug.Conn

  alias Comeonin.Bcrypt
  alias NotABlog.Accounts.User
  alias NotABlog.Repo

  @error_message "Incorrect username or password"

  def authenticate_user(username, password) do
    Ecto.Query.from(user in User, where: user.name == ^username)
    |> Repo.one
    |> check_password(password)
  end

  def login(conn, user) do
    conn
    |> put_session(:user_id, user.id)
    |> assign(:current_user, user)
  end

  def logout(conn) do
    conn
    |> put_session(:user_id, nil)
    |> assign(:current_user, nil)
  end

  def current_user(conn) do
    case get_session(conn, :user_id) do
      nil -> nil
      id  -> Repo.get(User, id)
    end
  end

  def logged_in?(conn) do
    !!current_user(conn)
  end

  defp check_password(nil, _given_password), do: {:error, @error_message}

  defp check_password(user, password) do
    case Bcrypt.checkpw(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, @error_message}
    end
  end
end
