defmodule TheLongDragWeb.ViewHelpers do
  def title do
    Cachex.fetch(:tld_cache, "title", &commit_title/0)
    |> title()
  end

  defp title({:ok, title}) do
    title
  end

  defp title({:commit, title}) do
    title
  end

  defp commit_title() do
    {:commit, TheLongDrag.Schema.Site.get().title}
  end
end
