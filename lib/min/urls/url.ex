defmodule Min.URLs.URL do
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "urls" do
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
