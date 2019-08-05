defmodule NotABlog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :content, :string
    field :title, :string
    field :views, :integer

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :views, :content])
    |> validate_required([:title, :views, :content])
    |> validate_length(:title, max: 200)
    |> validate_number(:views, greater_than_or_equal_to: 0)
  end
end
