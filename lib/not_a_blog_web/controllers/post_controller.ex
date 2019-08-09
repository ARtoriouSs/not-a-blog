defmodule NotABlogWeb.PostController do
  use NotABlogWeb, :controller

  alias NotABlog.Repo
  alias NotABlog.Blog
  alias NotABlog.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    post
    |> Post.changeset(%{views: post.views + 1})
    |> Repo.update()
    render(conn, "show.html", post: post)
  end

  def new(conn, _params) do
    render(conn, "new.html", changeset: Post.changeset(%Post{}, %{}))
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get(Post, id)
    render(conn, "edit.html", post: post, changeset: Post.changeset(post, %{}))
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully created")
        |> redirect(to: post_path(conn, :show, post.id))
      {:error, changeset} -> render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)
    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully updated")
        |> redirect(to: post_path(conn, :show, post.id))
      {:error, changeset} -> render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    case Repo.delete(post) do
      {:ok, _struct} ->
        conn
        |> put_flash(:info, "Post successfully deleted")
        |> redirect(to: post_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: post_path(conn, :index))
    end
  end
end
