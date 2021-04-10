# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :task_api,
  ecto_repos: [TaskApi.Repo]

# Configures the endpoint
config :task_api, TaskApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rzNRewMa4UtaEju/OLOjEJFbkv0Zd2jeeOKt326+Z0Kxd7u7LKHzR52SwDMoBTQt",
  render_errors: [view: TaskApiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TaskApi.PubSub,
  live_view: [signing_salt: "vLxuuopb"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian Configuration
config :task_api, TaskApiWeb.Auth.Guardian,
  issuer: "task_api",
  secret_key: "5XFBuVD4L8+5ZUzA2lBF1DFoZL6zR0Bh/UabxapeBV6HhPBJwbPPg/pT95i+FJUw"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
