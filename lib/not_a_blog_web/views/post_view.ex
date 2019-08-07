defmodule NotABlogWeb.PostView do
  use NotABlogWeb, :view

  def publication_time(post) do
    Timex.format!(post.inserted_at, "%B, %-d %Y at %-H:%M", :strftime)
  end

  def content_preview(conn, post, preview_characters \\ 220) do
    if String.length(post.content) < preview_characters do
      post.content
      |> String.slice(0, preview_characters)
      |> Kernel.<>("... ")
      |> Kernel.<>(read_more_link(conn, post))
      |> raw
    else
      post.content
    end
  end

  defp read_more_link(conn, post) do
    link("Read more", to: post_path(conn, :show, post.id))
    |> Phoenix.HTML.Safe.to_iodata
    |> IO.chardata_to_string
  end
end
