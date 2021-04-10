defmodule TaskApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :description, :text
      add :status, :string
      add :owner, :string

      timestamps()
    end

  end
end
