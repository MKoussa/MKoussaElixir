defmodule Mkoussaelixir.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      timestamps(type: :utc_datetime)
    end
  end
end
