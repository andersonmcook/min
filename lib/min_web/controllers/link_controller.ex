defmodule MinWeb.LinkController do
  use MinWeb, :controller

  alias Min.Links
  alias MinWeb.Endpoint

  def create(conn, %{"url" => url}) do
    case Links.create(url) do
      {:ok, %{hash: hash}} ->
        url = Routes.link_url(Endpoint, :show, hash)
        json(conn, %{url: url})

      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> json(%{error: "Invalid URL"})
    end
  end

  def show(conn, %{"hash" => hash}) do
    case Links.get(hash) do
      nil -> redirect(conn, to: "/")
      %{url: url} -> redirect(conn, external: url)
    end
  end
end
