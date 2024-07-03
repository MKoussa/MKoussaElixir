defmodule Mkoussaelixir.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :thoughts, :string
      add :logins, :integer
      add :admin?, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
