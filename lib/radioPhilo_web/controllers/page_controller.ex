defmodule RadioPhiloWeb.PageController do
  use RadioPhiloWeb, :controller

  alias RadioPhilo.Chats

  def index(conn, _params) do
    messages = Chats.list_quotations |> Enum.reverse
    qTypeMap = %{"citation" => "is-dark", "viewer" => "is-info"}
    render(conn, "index.html", messages: messages, qTypeMap: qTypeMap)
  end
end
