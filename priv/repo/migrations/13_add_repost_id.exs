defmodule Mkoussaelixir.Repo.Migrations.AddRepostId do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :repost_id, :integer
    end
  end
end
