defmodule TheLongDrag.Schema.Site do
  use Ecto.Schema
  import Ecto.Query
  alias TheLongDrag.Schema.Site
  alias TheLongDrag.Repo

  schema "site" do
    field :title
    field :description
  end

  def get do
    Repo.one(
      from site in Site,
      select: site
    )
  end

  def create(%Site{} = site) do
    Repo.insert(
      site
    )
  end
end
