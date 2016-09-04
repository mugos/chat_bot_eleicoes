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

  @doc """
  Fall Back for unknow messages
  """
  def handle_event({ :message, _, user, _ }, messages), do: Sender.send(user, "Oooopppsss, nao entendi, poderia repetir??")
end
