defmodule NotABlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :role, :integer

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :role])
    |> validate_required([:name, :role])
    |> validate_length(:name, min: 3, max: 20)
    |> unique_constraint(:name)
    |> put_password_hash()
  end

  def auth_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :role])
    |> validate_required([:name, :password, :role])
    |> validate_length(:name, min: 3, max: 20)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:name)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
