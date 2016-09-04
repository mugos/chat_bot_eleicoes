defmodule Core.Messenger.Handlers.AboutCandidates do
  #
  use GenEvent

  # Alias
  alias Core.Messenger.Sender

  @moduledoc """
  """

  @doc """
  """
  def handle_event({:message, %{"actions" => [
      %{"name" => "SobreOCandidato", "parameters" => [
        %{"name" => "candidato", "required" => _,"value" => [
          %{"entity" => entity, "score" => _, "type" => type}
        ]
      }], "triggered" => _ }
      ], "intent" => "SobreOCandidato", "score" => _}, user, _}, messages) do

    IO.inspect entity
    IO.inspect type

    # Send a message
    Sender.send user, "Você quer saber mais sobe o candidato #{entity}"

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
