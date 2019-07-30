defmodule NotABlog.Repo do
  use Ecto.Repo,
    otp_app: :not_a_blog,
    adapter: Ecto.Adapters.Postgres
end
