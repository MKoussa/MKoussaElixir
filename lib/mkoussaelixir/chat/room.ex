defmodule Mkoussaelixir.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mkoussaelixir.Chat.Message

  schema "rooms" do
    field :description, :string
    field :name, :string
    has_many :messages, Message, on_delete: :delete_all
    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
    |> validate_length(:name, min: 3, max: 24)
    |> validate_length(:description, min: 3, max: 200)
  end
end
