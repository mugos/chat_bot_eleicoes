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
  get "/api/webhook" do
    # Fetch the Params
    params = fetch_query_params(conn).params

    # Check the challange token
    case Core.Messenger.EventServer.challenge(params) do
      {:ok, challange} ->
        conn |> resp(200, challange)
      _ ->
        conn |> resp(500, "")
    end
  end

  #
  match "/api/webhook", via: [:post] do
    # Read the request body
    { :ok, body, conn } = read_body(conn)

    # res = body |> Poison.decode! |> Core.Mock.analyze

    # IO.inspect res

    # Send to the parser
    Core.Messenger.EventServer.receive body

    # Respond the 200
    conn |> resp(200, "OK")
  end

  # Catch ALL
  match _ do
    conn |> resp(404, "Oops")
  end
end
