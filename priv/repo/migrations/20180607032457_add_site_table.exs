defmodule TheLongDrag.Repo.Migrations.AddSiteTable do
  use Ecto.Migration

  def up do
    create table(:site) do
      add :title, :text, null: false, default: ""
      add :description, :text, null: false, default: ""
    end
  end

  def down do
    drop table :site
  end
end
