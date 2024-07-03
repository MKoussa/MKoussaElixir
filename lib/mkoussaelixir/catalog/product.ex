defmodule Mkoussaelixir.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Mkoussaelixir.Catalog.Category

  schema "products" do
    field :description, :string
    field :title, :string
    field :price, :decimal
    field :views, :integer

    many_to_many :categories, Category, join_through: "product_categories", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:title, :category, :description, :price, :views])
    |> validate_required([:title, :category, :description, :price, :views])
  end
end
