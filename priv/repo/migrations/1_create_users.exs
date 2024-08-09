defmodule Mkoussaelixir.Repo.Migrations.CreateUsersAuthTables do
  alias Mkoussaelixir.Accounts.PublicProfile
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:public_profile) do
      add :username, :string
      add :bio, :string
      add :online?, :boolean
    end

    create table(:users) do
      add :uuid, :uuid
      add :email, :citext, null: false
      add :admin?, :boolean
      add :hashed_password, :string, null: false
      add :confirmed_at, :utc_datetime
      add :public_profile, :map, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])

    create table(:users_tokens) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string

      timestamps(type: :utc_datetime, updated_at: false)
    end

    create index(:users_tokens, [:user_id])
    create unique_index(:users_tokens, [:context, :token])
  end
end
