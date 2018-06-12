defmodule TheLongDragWeb.FrontPageController do
  use TheLongDragWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
