defmodule TaskApi.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :name, :string
    field :owner, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :status, :owner])
    |> validate_required([:name, :description, :status, :owner])
  end
end
