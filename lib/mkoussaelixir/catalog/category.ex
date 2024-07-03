defmodule Mkoussaelixir.Catalog.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [])
    |> validate_required([])
  end
end
