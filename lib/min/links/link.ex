defmodule Min.Links.Link do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "links" do
    field :hash, :string
    field :url, EctoFields.URL
    timestamps()
  end

  def changeset(url \\ %__MODULE__{}, params) do
    url
    |> cast(params, [:hash, :url])
    |> validate_required([:hash, :url])
    |> unique_constraint(:hash)
  end
end
