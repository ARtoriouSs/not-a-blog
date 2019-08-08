defmodule NotABlog.Auth.AccessPlug do
  import Plug.Conn
  import Phoenix.Controller
  alias NotABlogWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "You need to log in to do it")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
      id -> conn
    end
  end
end
