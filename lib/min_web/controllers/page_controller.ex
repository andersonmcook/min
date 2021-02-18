defmodule MinWeb.PageController do
  use MinWeb, :controller

  alias MinWeb.Endpoint

  def index(conn, _params) do
    render(conn, "index.html", server: Routes.page_url(Endpoint, :index))
  end
end
