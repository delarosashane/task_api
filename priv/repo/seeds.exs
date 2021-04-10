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
Repo.insert! %Task{name: "Task 1", description: "Test Task 1", status: "todo"}
Repo.insert! %Task{name: "Task 2", description: "Test Task 2", status: "todo"}
Repo.insert! %Task{name: "Task 3", description: "Test Task 3", status: "todo"}
