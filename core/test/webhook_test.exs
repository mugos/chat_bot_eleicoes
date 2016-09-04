defmodule WebhookTest do
  use ExUnit.Case
  doctest Core

  # use Maru.Test, for: Core.Router.Webhook
  use Plug.Test

  test "test handshake" do
    IO.inspect conn(:get, "/")

    # assert %Plug.Conn{
    #   resp_body: "It works! port: 8800"
    # } = conn(:post, "api/webhook")
  end
end
