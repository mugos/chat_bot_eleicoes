defmodule GenEventTest do
  use ExUnit.Case
  doctest Core

  alias Core.Messenger.EventServer
  alias Core.Messenger.Handlers

  test "test gen even notify" do
    { :ok, _} = EventServer.start_link []
    :ok = EventServer.add_handler Handlers.GreetingHandler
    :ok = EventServer.notify {:message, 'GreetingMessage'}
  end
end
