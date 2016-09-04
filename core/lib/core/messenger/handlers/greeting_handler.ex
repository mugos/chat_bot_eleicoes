defmodule Core.Messenger.Handlers.GreetingHandler do
  #
  use GenEvent

  # Alias
  alias Core.Messenger.Sender

  @moduledoc """
  """

  @doc """
  """
  def handle_event({:message, 'GreetingMessage', recipient}, messages) do
    # IO.inspect "hello from the prety handler"

    #
    # IO.inspect messages

    # Send a message
    Sender.send recipient, "Bom dia!"

    # OK!
    { :ok, messages }
  end
end
