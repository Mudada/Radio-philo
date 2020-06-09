defmodule RadioPhilo.Chats.Quotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotations" do
    field :body, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(quotation, attrs) do
    quotation
    |> cast(attrs, [:name, :body])
    |> validate_required([:name, :body])
  end
end
