defmodule Mkoussaelixir.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :string
      add :repost_id, :integer
      add :poster_id, references(:users), null: false, on_delete: :delete_all
      add :comments, :map, default: %{}
      add :likes, :map, default: %{}

      timestamps(type: :utc_datetime)
    end
  end
end
