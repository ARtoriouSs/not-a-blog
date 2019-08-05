defmodule NotABlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :password_hash, :string
      add :role, :integer, default: 0

      timestamps()
    end
  end
end
