defmodule TaskApiWeb.Auth.Pipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline, otp_app: :task_api,
    module: TaskApiWeb.Auth.Guardian,
    error_handler: TaskApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
