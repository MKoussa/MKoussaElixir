defmodule Mkoussaelixir.Accounts.PublicProfile do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :username, :string, default: "New User"
    field :bio, :string, default: "There's nothing here..."
    field :online?, :boolean, default: false
  end

  def changeset(profile, attrs \\ %{}) do
    profile
    |> cast(attrs, [:username, :bio, :online?])
  end
end
