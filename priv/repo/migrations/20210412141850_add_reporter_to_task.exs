defmodule TaskApi.Repo.Migrations.AddReporterToTask do
  use Ecto.Migration

  def up do
    alter table(:tasks) do
      add :reporter, :string
    end
  end

  def down do
    remove :reporter
  end
end
