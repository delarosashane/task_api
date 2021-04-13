defmodule TaskApi.TodoTest do
  use TaskApi.DataCase

  alias TaskApi.Todo

  setup do
    # Adds user for validation
    TaskApi.Repo.insert!(%TaskApi.Accounts.User{username: "some owner", email: "email2@email.com"})

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  describe "tasks" do
    alias TaskApi.Todo.Task

    @valid_attrs %{description: "some description", name: "some name", owner: "some owner", status: "todo", reporter: "some owner"}
    @update_attrs %{description: "some updated description", name: "some updated name", owner: "some updated owner", status: "done", reporter: "some owner"}
    @invalid_attrs %{description: nil, name: nil, owner: nil, status: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Todo.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.name == "some name"
      assert task.owner == "some owner"
      assert task.status == "todo"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todo.update_task(task, @update_attrs)
      assert task.description == "some updated description"
      assert task.name == "some updated name"
      assert task.owner == "some updated owner"
      assert task.status == "done"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end

    test "reorder_task/1 with valid params returns ordered list of tasks - status, asc" do
      task_fixture()
      Todo.create_task(%{description: "some description", name: "some name 2", owner: "some owner", status: "in_progress", reporter: "some owner"})

      {:ok, tasks} = Todo.reorder_tasks(%{"sort_by" => "status", "order" => "asc"})
      assert "todo" == List.first(tasks).status
    end

    test "reorder_task/1 with valid params returns ordered list of tasks - status, desc" do
      task_fixture()
      Todo.create_task(%{description: "some description", name: "some name 2", owner: "some owner", status: "in_progress", reporter: "some owner"})

      {:ok, tasks} = Todo.reorder_tasks(%{"sort_by" => "status", "order" => "desc"})
      assert "in_progress" == List.first(tasks).status
    end

    test "reorder_task/1 with invalid params returns ordered list of tasks returns error changeset" do
      task_fixture()
      Todo.create_task(%{description: "some description", name: "some name 2", owner: "some owner", status: "in_progress", reporter: "some owner"})

      assert {:error, %Ecto.Changeset{}} = Todo.reorder_tasks(%{"sort_by" => "asdas", "order" => "asc"})
    end


  end
end
