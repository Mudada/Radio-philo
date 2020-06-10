defmodule RadioPhilo.Chats.Quotation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "quotations" do
    field :body, :string
    field :userName, :string
    field :label, :string

    timestamps()
  end

  @doc false
  def changeset(quotation, attrs) do
    quotation
    |> cast(attrs, [:label, :userName, :body])
    |> validate_required([:label, :userName, :body])
  end
end
