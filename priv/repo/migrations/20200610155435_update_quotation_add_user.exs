defmodule RadioPhilo.Repo.Migrations.UpdateQuotationAddUser do
  use Ecto.Migration

  def change do
    alter table(:quotations) do
      add :userName, :string
    end

    rename table(:quotations), :name, to: :label

  end
end
