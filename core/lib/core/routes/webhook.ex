defmodule Core.Router.Webhook do
  use Maru.Router

  version "v1"

  namespace :webhook do
    get do
      json conn, %{alive: true}
    end
  end
end
