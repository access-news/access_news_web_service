defmodule TR2WebWeb.PageController do
  use TR2WebWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
