defmodule Mkoussaelixir.Repo.Migrations.CreatePublicProfileTable do
  use Ecto.Migration

  def change do
    create table(:public_profile) do
      add :username, :string
      add :bio, :string
      add :online?, :boolean
    end
  end
end
