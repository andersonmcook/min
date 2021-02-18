defmodule Min.Links do
  @moduledoc false

  alias Min.Repo
  alias Min.Links.Link

  # We could re-hash on collision
  @spec create(String.t()) :: {:ok, Link.t()} | {:error, Ecto.Changeset.t()}
  def create(url) do
    hash = hash(url)

    case get(hash) do
      nil ->
        %{hash: hash, url: url}
        |> Link.changeset()
        |> Repo.insert()

      %{url: ^url} = link ->
        {:ok, link}
    end
  end

  # We could cache in ETS when not nil
  @spec get(String.t()) :: nil | Link.t()
  def get(hash) do
    Repo.get_by(Link, hash: hash)
  end

  @spec hash(String.t(), 2..36) :: String.t()
  defp hash(string, base \\ 16) do
    string
    |> :erlang.crc32()
    |> Integer.to_string(base)
    |> String.downcase()
  end
end
