defmodule TaskApi.Todo.Task do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  alias TaskApi.Accounts
  alias TaskApi.Repo
  alias Accounts.User

  schema "tasks" do
    field :description, :string
    field :name, :string
    field :owner, :string
    field :status, :string
    field :reporter, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description, :status, :owner, :reporter])
    |> validate_required([:name, :status, :reporter])
    # |> validate_key(:owner) removes owner validation for faster creation
    |> validate_key(:reporter)
    |> validate_status()
  end

  @doc false
  def changeset_reorder(attrs) do
    data  = %{}
    types = %{sort_by: :string, order: :string}
    changeset =
      {data, types}
      |> cast(attrs, Map.keys(types))
      |> validate_required([:sort_by, :order])
      |> validate_key(:sort_by)
      |> validate_inclusion(:order, ["asc", "desc", "ASC", "DESC"])

    if changeset.valid? do
      {:ok, attrs}
    else
      {:error, changeset}
    end
  end

  defp validate_key(%{changes: %{sort_by: sort_by}} = changeset, :sort_by) do
    if changeset.valid? do
      sort = ["name", "description", "status", "owner", "reporter", "inserted_at", "updated_at", "id"]

      case Enum.member?(sort, String.downcase(sort_by)) do
        true ->
          changeset
        _ ->
          add_error(changeset,
          :sort_by,
          "Sort by is invalid. Available sorting: [name, description, status, owner, reporter, inserted_at, updated_at, id]"
        )
      end
    end
  end

  defp validate_key(changeset, key) do
    if changeset.valid? do
      val = changeset |> get_field(key)

      case Repo.get_by(User, username: val) do
        nil ->
          changeset
          |> add_error(
            key,
            "#{Atom.to_string(key)} does not exist. Please use an existing user in the DB"
          )
        _user ->
          changeset
      end
    else
      changeset
    end
  end

  defp validate_status(%{changes: %{status: status}} = changeset) do
    status_list = ["todo", "in_progress", "for_testing", "deploy_ready", "done"]
    case Enum.member?(status_list, String.downcase(status)) do
      true ->
        changeset
      _ ->
        add_error(changeset,
          :status,
          "Status is invalid. Available status: [todo, in_progress, for_testing, deploy_ready, done]"
        )
    end
  end

  defp validate_status(changeset), do: changeset
end
