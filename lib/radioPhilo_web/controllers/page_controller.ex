defmodule RadioPhiloWeb.PageController do
  use RadioPhiloWeb, :controller

  alias RadioPhilo.Chats

  def index(conn, _params) do
    messages = Chats.list_quotations |> Enum.reverse
    render(conn, "index.html", messages: messages)
  end
end
