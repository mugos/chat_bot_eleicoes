defmodule WebhookTest do
  use ExUnit.Case
  doctest Core

  use Maru.Test, for: Core.Router.Webhook

  test "test handshake" do
    assert %Plug.Conn{
      resp_body: "It works! port: 8800"
    } = conn(:get, "/webhook") |> make_response
  end
end
