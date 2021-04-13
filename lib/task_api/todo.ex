defmodule TaskApi.Todo do
  @moduledoc """
  The Todo context.
  """

  import Ecto.Query, warn: false
  alias TaskApi.Repo

  alias TaskApi.Todo.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Returns the list of tasks by order
  """
  def reorder_tasks(parameters) do
    case Task.changeset_reorder(parameters) do
      {:ok, params} ->
        params = params |> sort_tasks()
        {:ok, params}
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  @status_sorting """
    (case(?)
      when 'todo' then 1
      when 'in_progress' then 2
      when 'for_testing' then 3
      else 4
    end)
  """
  defp sort_tasks(%{"sort_by" => "status", "order" => sort}) do
    if sort == "asc" do
      Task
      |> order_by([t], asc: fragment(@status_sorting, t.status))
      |> Repo.all()
    else
      Task
      |> order_by([t], desc: fragment(@status_sorting, t.status))
      |> Repo.all()
    end
  end

  defp sort_tasks(%{"sort_by" => key, "order" => sort}) do
    key = String.to_atom(key)
    case sort do
      "asc" ->
        Task
        |> order_by(asc: ^key)
        |> Repo.all()
      _ ->
        Task
        |> order_by(desc: ^key)
        |> Repo.all()
    end
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
