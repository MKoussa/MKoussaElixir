defmodule Mkoussaelixir.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mkoussaelixir.Posts.Post
  alias Mkoussaelixir.Accounts.User

  schema "comments" do
    field :content, :string

    belongs_to :post, Post
    belongs_to :commenter, User

    timestamps(type: :utc_datetime)
  end

  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:content, :post_id, :commenter_id])
    |> validate_required([:content, :post_id, :commenter_id])
    |> validate_length(:content, min: 3, max: 140)
  end
end
