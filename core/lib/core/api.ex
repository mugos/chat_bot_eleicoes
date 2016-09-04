defmodule Core.API do
  @moduledoc """
  """

  # Plug router
  use Plug.Router

  # Default Plugs
  plug :match
  plug :dispatch

  # Extensions Plugs
  plug CORSPlug
  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison

  #
  match "/api/webhook", via: [:post] do
    # Read the request body
    { :ok, body, conn } = read_body(conn)

    # Send to the parser
    Core.Messenger.receive body

    # Respond the 200
    send_resp(conn, 200, "")
  end

  # Catch ALL
  match _ do
    send_resp(conn, 404, "Oops")
  end
end
