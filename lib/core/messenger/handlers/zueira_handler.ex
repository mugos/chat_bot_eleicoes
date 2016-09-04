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
          %{"entity" => entity, "score" => _, "type" => _}
        ]
      }], "triggered" => _ }
      ], "intent" => "SobreOCandidato", "score" => _}, user, _}, messages) do

    # Send a message
    Sender.send user, "O #{Strin.capitalize(info_candidate)} pertence ao partido #{Enum.random(["PEN", "SD", "NOVO"])} e nao possui grande autacao na politica."
    Sender.send user, "Voce se interresa no trabalho dele?"

    # OK!
    { :ok, messages }
  end

  @doc """
  Fall Back for unknow messages
  """
  def handle_event(_, messages), do: { :ok, messages }
end
