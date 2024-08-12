defmodule Mkoussaelixir.Accounts.PublicProfile do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :username, :string, default: "New User"
    field :bio, :string, default: "There's nothing here..."
    field :online?, :boolean, default: false
    field :public_post_background_color, :string
    field :public_post_foreground_color, :string
  end

  def changeset(profile, attrs \\ %{}) do
    profile
    |> cast(attrs, [
      :username,
      :bio,
      :online?,
      :public_post_background_color,
      :public_post_foreground_color
    ])
  end
end
