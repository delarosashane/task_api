# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskApi.Repo.insert!(%TaskApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TaskApi.{
  Todo,
  Accounts
}

# Inserts a user for login
IO.puts("Seeding User")
Accounts.create_user(%{email: "admin@email.com", password: "P@ssw0rd", username: "masteradmin"})

# Tasks data
tasks = [
  %{name: "Task 1", description: "Test Task 1", status: "todo", reporter: "masteradmin"},
  %{name: "Task 2", description: "Test Task 2", status: "todo", reporter: "masteradmin"},
  %{name: "Task 3", description: "Test Task 3", status: "todo", reporter: "masteradmin"}
]


IO.puts("Seeding Tasks")

Enum.each(tasks, fn(task) ->
  Todo.create_task(task)
end)
