defmodule NotABlog.Blog do
  import Ecto.Query, warn: false

  alias NotABlog.Repo
  alias NotABlog.Blog.Post

  def list_posts do
    Post
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end
end
