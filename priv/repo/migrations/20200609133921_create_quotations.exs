defmodule RadioPhilo.Repo.Migrations.CreateQuotations do
  use Ecto.Migration

  def change do
    create table(:quotations) do
      add :name, :string
      add :body, :text

      timestamps()
    end

  end
end
