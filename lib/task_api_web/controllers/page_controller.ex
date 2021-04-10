defmodule TaskApiWeb.PageController do
  use TaskApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
