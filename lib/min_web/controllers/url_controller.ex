defmodule MinWeb.URLController do
  use MinWeb, :controller

  alias Min.URLs
  alias MinWeb.Endpoint

  def create(conn, %{"url" => url}) do
    case URLs.create(url) do
      {:ok, %{hash: hash}} ->
        url = Routes.url_path(Endpoint, :show, hash)
        json(conn, %{url: url})

      {:error, _changeset} ->
        conn
        |> put_status(400)
        |> json(%{error: "Invalid URL"})
    end
  end

  def show(conn, %{"hash" => hash}) do
    case URLs.get(hash) do
      nil -> redirect(conn, to: "/")
      %{url: url} -> redirect(conn, external: url)
    end
  end
end
