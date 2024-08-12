defmodule Mkoussaelixir.Repo.Migrations.CreatePublicProfileTable do
  use Ecto.Migration

  def change do
    create table(:public_profile) do
      add :username, :string
      add :bio, :string
      add :online?, :boolean
      add :public_post_background_color, :string
      add :public_post_foreground_color, :string
    end
  end
end
