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
  """
  def handle_event({:message, %{"intent" => "Despedida", "score" => _}, user, _}, messages) do
    # Send a message
    Sender.send user, "Foi boa a conversa, ate a proxima."

    # OK!
    { :ok, messages }
  end


  @doc """
  Fall Back for unknow messages
  """
  def handle_event({ :message, intent, user, _ }, messages) do
    # Intent
    IO.inspect intent

    # Send msg
    Sender.send(user, "Opa, não entendi, tente algo como: \n \"Oi\"")

    # OK!
    { :ok, messages }
  end
end
