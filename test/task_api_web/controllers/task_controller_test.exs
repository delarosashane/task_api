defmodule TaskApiWeb.TaskControllerTest do
  use TaskApiWeb.ConnCase

  alias TaskApi.Todo
  alias TaskApi.Todo.Task

  @create_attrs %{
    description: "some description",
    name: "some name",
    owner: "some owner",
    status: "todo",
    reporter: "some owner"
  }

  @fixture_attrs %{
    description: "some description",
    name: "some name",
    owner: "some owner",
    status: "todo",
    reporter: "some owner"
  }

  @update_attrs %{
    description: "some updated description",
    name: "some updated name",
    owner: "some updated owner",
    status: "in_progress",
    reporter: "some updated owner"
  }
  @invalid_attrs %{description: nil, name: nil, owner: nil, status: nil}

  def fixture(:task) do
    {:ok, task} = Todo.create_task(@fixture_attrs)
    task
  end

  setup do
    # Adds a user session
    user = TaskApi.Repo.insert!(%TaskApi.Accounts.User{username: "some owner", email: "email@email.com"})
    # Adds user for update attrs
    TaskApi.Repo.insert!(%TaskApi.Accounts.User{username: "some updated owner", email: "email2@email.com"})

    conn = Phoenix.ConnTest.build_conn()
            |> sign_conn()
            |> TaskApiWeb.Auth.Guardian.Plug.sign_in(user)
    {:ok, conn: conn}
  end

  describe "index" do
    test "lists all tasks", %{conn: auth_conn} do
      conn = get(auth_conn, Routes.task_path(auth_conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create task" do
    test "renders task when data is valid", %{conn: auth_conn} do
      conn = post(auth_conn, Routes.task_path(auth_conn, :create), task: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(auth_conn, Routes.task_path(auth_conn, :show, id))

      assert %{
               "id" => _id,
               "description" => "some description",
               "name" => "some name",
               "owner" => "some owner",
               "status" => "todo"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: auth_conn} do
      conn = post(auth_conn, Routes.task_path(auth_conn, :create), task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task" do
    setup [:create_task]

    test "renders task when data is valid", %{conn: auth_conn, task: %Task{id: id} = task} do

      conn = put(auth_conn, Routes.task_path(auth_conn, :update, task), task: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(auth_conn, Routes.task_path(auth_conn, :show, id))

      assert %{
               "id" => _id,
               "description" => "some updated description",
               "name" => "some updated name",
               "owner" => "some updated owner",
               "status" => "in_progress"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: auth_conn, task: task} do
      conn = put(auth_conn, Routes.task_path(auth_conn, :update, task), task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: auth_conn, task: task} do
      conn = delete(auth_conn, Routes.task_path(auth_conn, :delete, task))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(auth_conn, Routes.task_path(auth_conn, :show, task))
      end
    end
  end

  describe "reorder task" do
    test "reorders tasks", %{conn: auth_conn} do
      params = %{sort_by: "status", order: "asc"}
      conn = post(auth_conn, Routes.task_path(auth_conn, :reorder, params))
      assert json_response(conn, 200)["data"] == []
    end
  end

  defp create_task(_) do
    task = fixture(:task)
    %{task: task}
  end


  # Adds session for tests
  @default_opts [
    store: :cookie,
    key: "foobar",
    encryption_salt: "encrypted cookie salt",
    signing_salt: "signing salt"
  ]

  @secret String.duplicate("abcdef0123456789", 8)
  @signing_opts Plug.Session.init(Keyword.put(@default_opts, :encrypt, false))

  defp sign_conn(conn, secret \\ @secret) do
    put_in(conn.secret_key_base, secret)
    |> Plug.Session.call(@signing_opts)
    |> fetch_session
  end

end
