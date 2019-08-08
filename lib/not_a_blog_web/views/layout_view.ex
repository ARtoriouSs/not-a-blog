defmodule NotABlogWeb.LayoutView do
  use NotABlogWeb, :view

  import NotABlog.Auth, only: [current_user: 1, logged_in?: 1]
end
