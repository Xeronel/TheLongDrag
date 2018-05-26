defmodule TheLongDrag.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION pgcrypto"
    create table(:users) do
      add :username, :text, null: false
      add :pwhash, :text, null: false
      add :first_name, :text, null: false
      add :last_name, :text, null: false
      add :last_seen, :timestamp, null: false, default: fragment "NOW()"
      add :last_ip, :inet, null: false
      add :user_timezone, :text, null: false, default: "America/New_York"
      add :email, :text, null: false
      add :pw_modified, :timestamp, null: false, default: fragment "NOW()"

      timestamps()
    end

    create constraint(:users, "username_must_be_lowercase", check: "username = lower(username)")
    create constraint(:users, "email_must_be_lowercase", check: "email = lower(email)")
    create unique_index(:users, :username)
    create unique_index(:users, :email)

    alter table(:users) do
      modify :updated_at, :timestamp, default: fragment "NOW()"
    end
  end

  def down do
    drop table("users")
  end
end
