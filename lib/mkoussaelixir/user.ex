defmodule Mkoussaelixir.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :thoughts, :string
    field :logins, :integer
    field :admin?, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :thoughts, :logins, :admin?])
    |> validate_required([:name, :thoughts, :logins, :admin?])
  end
end
