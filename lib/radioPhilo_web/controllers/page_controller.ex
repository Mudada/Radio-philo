defmodule RadioPhiloWeb.PageController do
  use RadioPhiloWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
