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

    # Send a message
    Sender.send user, "Você quer saber mais sobe o candidato #{entity}"

    # OK!
    { :ok, messages }
  end

  @doc """
  Fall Back for unknow messages
  """
  def handle_event(_, messages), do: { :ok, messages }
end
