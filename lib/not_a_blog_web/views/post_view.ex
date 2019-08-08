defmodule NotABlogWeb.PostView do
  use NotABlogWeb, :view

  def publication_time(post) do
    Timex.format!(post.inserted_at, "%B, %-d %Y at %-H:%M", :strftime)
  end

  def content_preview(conn, post, preview_characters \\ 220) do
    if String.length(post.content) > preview_characters do
      post.content
      |> String.slice(0, preview_characters)
      |> Kernel.<>("... ")
      |> Kernel.<>(show_post_link(conn, post, "Read more"))
      |> raw
    else
      post.content
      |> Kernel.<>(" ")
      |> Kernel.<>(show_post_link(conn, post, "View post"))
      |> raw
    end
  end

  defp show_post_link(conn, post, text \\ "Read more") do
    link(text, to: post_path(conn, :show, post.id))
    |> Phoenix.HTML.Safe.to_iodata
    |> IO.chardata_to_string
  end
end
