defmodule TaskApiWeb.TaskController do
  use TaskApiWeb, :controller

  alias TaskApi.Todo
  alias TaskApi.Todo.Task

  action_fallback TaskApiWeb.FallbackController

  def index(conn, _params) do
    tasks = Todo.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    task_params = add_reporter(conn, task_params)
    with {:ok, %Task{} = task} <- Todo.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task_params = add_reporter(conn, task_params)

    task = Todo.get_task!(id)

    with {:ok, %Task{} = task} <- Todo.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)

    with {:ok, %Task{}} <- Todo.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end

  @spec reorder(
          Plug.Conn.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Plug.Conn.t()
  def reorder(conn, task_params) do
    with {:ok, tasks} <- Todo.reorder_tasks(task_params) do
      render(conn, "index.json", tasks: tasks)
    end
  end

  # Adds current user if there is no reporter in parameters
  defp add_reporter(conn, %{"reporter" => reporter} = params) when is_binary(reporter) do
    if reporter == "", do: add_reporter(conn, Map.delete(params, "reporter")), else: params
  end

  defp add_reporter(conn, params) do
    user = Guardian.Plug.current_resource(conn)

    Map.put(params, "reporter", user.username)
  end
end
