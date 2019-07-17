defmodule AccessNewsWeb.PageController do
  use AccessNewsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
