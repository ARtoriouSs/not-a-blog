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
    render(conn, "new.html")
  end

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def create(conn, _params) do

  end

  def delete(conn, _params) do

  end
end
