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
    Sender.send user, "Em que posso te ajudar?"

    # OK!
    { :ok, messages }
  end

  @doc """
  """
  def handle_event({:message, %{"intent" => "Negativo", "score" => _}, user, _}, messages) do
    # Send a message
    Sender.send user, "Ok, entao"

    # OK!
    { :ok, messages }
  end

  @doc """
  """
  def handle_event({:message, %{"intent" => "Despedida", "score" => _}, user, _}, messages) do
    # Send a message
    Sender.send user, "Foi boa a conversa, qualquer coisa to sempre por aqui, ate a proxima."

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
    Sender.send(user, "OOOpppsss, nao entendi")

    # OK!
    { :ok, messages }
  end
end
