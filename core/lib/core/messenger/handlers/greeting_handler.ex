defmodule Core.Messenger.Handlers.GreetingHandler do
  #
  use GenEvent

  @moduledoc """
  """

  @doc """
  """
  def handle_event({:message, 'GreetingMessage'}, messages) do
    #
    IO.inspect messages

    # OK!
    { :ok, messages }
  end
end
