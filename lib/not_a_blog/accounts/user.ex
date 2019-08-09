defmodule NotABlog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password_hash, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 3, max: 20)
    |> unique_constraint(:name)
  end

  def reset_password_changeset(user, attrs) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_length(:password, min: 6)
    |> check_password_confirmation()
  end

  def auth_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> validate_length(:name, min: 3, max: 20)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:name)
    |> put_password_hash()
  end

  defp check_password_confirmation(changeset) do
    case changeset.changes do
      %{password: password, password_confirmation: password_confirmation} ->
        if password == password_confirmation do
          changeset
          |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
          |> delete_change(:password)
          |> delete_change(:password_confirmation)
        else
          add_error(changeset, :password_confirmation, "Passwords don't match")
        end
      _ -> changeset
    end
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        changeset
        |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(password))
        |> delete_change(:password)
      _ -> changeset
    end
  end
end
