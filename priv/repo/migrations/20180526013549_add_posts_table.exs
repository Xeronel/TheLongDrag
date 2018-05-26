defmodule TheLongDrag.Repo.Migrations.AddPostsTable do
  use Ecto.Migration

  def up do
    create table(:posts) do
      add :user_id, references(:users), null: false
      add :title, :text, null: false
      add :body, :text, null: false
      add :pinned, :boolean, null: false, default: false
      add :sort_weight, :integer, null: false, default: 0
      timestamps()
    end
  end

  def down do
    drop table("posts")
  end
end
