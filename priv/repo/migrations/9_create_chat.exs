defmodule Mkoussaelixir.Repo.Migrations.CreateChat do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :description, :string

      timestamps()
    end

    create table(:messages) do
      add :content, :string
      add :sender_id, references(:users), null: false
      add :room_id, references(:rooms), null: false, on_delete: :delete_all

      timestamps()
    end
  end
end
