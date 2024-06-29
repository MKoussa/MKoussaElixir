defmodule Mkoussaelixir.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :title, :string
    field :category, :string
    field :price, :decimal
    field :views, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :category, :description, :price, :views])
    |> validate_required([:title, :category, :description, :price, :views])
  end
end
