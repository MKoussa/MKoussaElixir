defmodule Mkoussaelixir.Chat.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mkoussaelixir.Chat.Room
  alias Mkoussaelixir.Accounts.User

  schema "messages" do
    field :content, :string
    belongs_to :room, Room
    belongs_to :sender, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :sender_id, :room_id])
    |> validate_required([:content, :sender_id, :room_id])
  end
end
