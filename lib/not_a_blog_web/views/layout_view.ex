defmodule NotABlogWeb.LayoutView do
  use NotABlogWeb, :view

  import NotABlog.Auth, only: [logged_in?: 1, current_user: 1]
end
