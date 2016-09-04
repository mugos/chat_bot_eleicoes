defmodule Core.Messenger.Handlers.GreetingHandler do
  #
  use GenEvent

  # Alias
  alias Core.Messenger.Sender

  @moduledoc """
  """

  @doc """
  """
  def handle_event({:message, %{"intent" => "Saudacao", "score" => _}, user, _}, messages) do
    # Send a message
    Sender.send user, "Ola #{user}"

    # OK!
    { :ok, messages }
  end
end
