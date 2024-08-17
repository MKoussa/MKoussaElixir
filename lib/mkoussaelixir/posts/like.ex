defmodule Mkoussaelixir.Posts.Like do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mkoussaelixir.Posts.Post
  alias Mkoussaelixir.Accounts.User

  schema "likes" do
    field :like_color, :string

    belongs_to :post, Post
    belongs_to :liker, User

    timestamps(type: :utc_datetime)
  end

  def changeset(like, attrs) do
    like
    |> cast(attrs, [:post_id, :liker_id, :like_color])
    |> validate_required([:post_id, :liker_id, :like_color])
    |> validate_length(:like_color, is: 7)
  end
end
