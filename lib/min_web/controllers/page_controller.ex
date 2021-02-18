defmodule MinWeb.PageController do
  use MinWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
