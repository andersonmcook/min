defmodule Min.URLs do
  @moduledoc false

  alias Min.Repo
  alias Min.URLs.URL

  # We could re-hash on collision
  @spec create(String.t()) :: {:ok, URL.t()} | {:error, Ecto.Changeset.t()}
  def create(url) do
    hash = hash(url)

    case get(hash) do
      nil ->
        %{hash: hash, url: url}
        |> URL.changeset()
        |> Repo.insert()

      %{url: ^url} = url_struct ->
        {:ok, url_struct}
    end
  end

  # We could cache in ETS when not nil
  @spec get(String.t()) :: nil | URL.t()
  def get(hash) do
    Repo.get_by(URL, hash: hash)
  end

  defp hash(string, base \\ 16) do
    string
    |> :erlang.crc32()
    |> Integer.to_string(base)
    |> String.downcase()
  end
end
