defmodule RadioPhiloWeb.QuotationChannel do
  use RadioPhiloWeb, :channel

  alias RadioPhilo.Chats

  @impl true
  def join("quotation:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (quotation:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    case Chats.create_quotation(payload) do
      {:ok, %{id: id, userName: userName, label: label, body: body} = _newQ} ->
        broadcast socket, "shout", %{id: id, userName: userName, label: label, body: body}
      {:error, _we} -> ""
    end
    {:noreply, socket}
  end

  @impl true
  def handle_in("delete", payload, socket) do
    Chats.get_quotation!(Map.get(payload, "id"))
    |> Chats.delete_quotation()
    broadcast socket, "delete", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
