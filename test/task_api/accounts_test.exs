defmodule TaskApi.AccountsTest do
  use TaskApi.DataCase

  alias TaskApi.Accounts

  describe "users" do
    alias TaskApi.Accounts.User

    @valid_attrs %{email: "email@email.com", password: "some hashed_password", username: "some_username"}
    @update_attrs %{email: "email_update@email.com", password: "some updated hashed_password", username: "some_username_update"}
    @invalid_attrs %{email: nil, password: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()

      usernames = Enum.map(Accounts.list_users(), &(&1.username))
      assert usernames == [user.username]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).username == user.username
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "email@email.com"
      assert user.username == "some_username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "email_update@email.com"
      assert user.username == "some_username_update"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.username == Accounts.get_user!(user.id).username
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
