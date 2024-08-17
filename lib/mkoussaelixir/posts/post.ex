defmodule Mkoussaelixir.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mkoussaelixir.Accounts.User
  alias Mkoussaelixir.Posts.Like

  schema "posts" do
    field :content, :string

    has_many :likes, Like
    belongs_to :poster, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:poster_id, :content])
    |> validate_required([:poster_id, :content])
    |> validate_length(:content, min: 3, max: 140)
  end
end
