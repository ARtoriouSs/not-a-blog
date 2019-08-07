defmodule NotABlogWeb.PostController do
  use NotABlogWeb, :controller

  alias NotABlog.Repo
  alias NotABlog.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id} = _params) do
    post = Repo.get(Post, id)
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: Post.changeset(%Post{}))
  end

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def create(conn, %{"post" => %{"title" => title, "content" => content}} = _params) do
    changeset = Post.changeset(%Post{}, %{title: title, content: content})
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully created")
        |> redirect(to: post_path(conn, :show, post.id))
      {:error, changeset} -> render conn, "new.html", changeset: changeset
    end
  end

  def delete(conn, %{"id" => id} = _params) do
    post = Repo.get!(Post, id)
    case Repo.delete(post) do
      {:ok, _struct} ->
        conn
        |> put_flash(:info, "Post successfully deleted")
        |> redirect to: post_path(conn, :index)
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect to: post_path(conn, :index)
    end
  end
end
