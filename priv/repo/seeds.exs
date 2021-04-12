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

alias TaskApi.Repo
alias TaskApi.Todo.Task
alias TaskApi.Accounts.User
alias TaskApi.Accounts

# Inserts a user for login
Accounts.create_user(%{email: "admin@email.com", password: "P@ssw0rd", username: "masteradmin"})

Repo.insert! %Task{name: "Task 1", description: "Test Task 1", status: "todo", reporter: "masteradmin"}
Repo.insert! %Task{name: "Task 2", description: "Test Task 2", status: "todo", reporter: "masteradmin"}
Repo.insert! %Task{name: "Task 3", description: "Test Task 3", status: "todo", reporter: "masteradmin"}
