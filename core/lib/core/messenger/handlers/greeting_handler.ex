defmodule Core.Messenger.Handlers.GreetingHandler do
  #
  use GenEvent

  # Alias
  alias Core.Messenger.Sender

  @moduledoc """
  """

  @doc """
  """
  def handle_event({:message, %{"intend": "Saudacao"}, user, _}, messages) do
    # Send a message
    Sender.send user, "Ola #{user}"

    # OK!
    { :ok, messages }
  end
end
