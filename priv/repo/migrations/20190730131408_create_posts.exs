defmodule NotABlog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :views, :integer, default: 0
      add :content, :string

      timestamps()
    end
  end
end
