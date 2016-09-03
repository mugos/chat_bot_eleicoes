defmodule Core.API do
  use Maru.Router
  plug CORSPlug
  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison

  mount Core.Router.Homepage

  rescue_from :all, as: e do
    IO.inspect(e)
    conn
    |> put_status(500)
    |> text("Server Error")
  end
end
