defmodule TaskApiWeb.Auth.Guardian do
  @moduledoc """
  Guardian functions for the App
  """
  use Guardian, otp_app: :task_api

  alias TaskApi.Accounts

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Accounts.get_user!(id)
    {:ok,  resource}
  end

  def authenticate(username, password) do
    with {:ok, user} <- Accounts.get_by_username(username) do
      case validate_pass(password, user.hashed_password) do
        true ->
          create_token(user)
        false ->
          {:error, :unauthorized}
      end
    end
  end

  defp validate_pass(password, hashed_password) do
    Comeonin.Bcrypt.checkpw(password, hashed_password)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
