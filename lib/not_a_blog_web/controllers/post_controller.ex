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
    render(conn, "new.html", changeset: empty_post)
  end

  def edit(conn, %{"id" => id} = _params) do
    post = Repo.get(Post, id)
    render(conn, "edit.html", post: post, changeset: Post.changeset(post, %{}))
  end

  def create(conn, %{"post" => post_params} = _params) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully created")
        |> redirect(to: post_path(conn, :show, post.id))
      {:error, changeset} -> render conn, "new.html", changeset: changeset
    end
  end

  def update(conn, %{"id" => id, "post" => post_params} = _params) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)
    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully updated")
        |> redirect(to: post_path(conn, :show, post.id))
      {:error, changeset} -> render conn, "edit.html", post: post, changeset: changeset
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

  defp empty_post do
    Post.changeset(%Post{}, %{})
  end
end
