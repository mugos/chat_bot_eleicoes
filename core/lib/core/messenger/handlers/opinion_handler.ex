defmodule Core.Messenger.Handlers.OpinionHandler do
  #
  use GenEvent

  # Alias
  alias Core.Messenger.Sender

  @moduledoc """
  """

  @doc """
  """
  def handle_event({:message, %{"intent" => "CapturarOpiniao", "score" => _}, user, _}, messages) do
    # Possbile messages
    possible = [
      "e porque voce acha isso?",
      "conte me mais",
      "interresante... vou anotar",
      "algo mais?"
    ]

    # Send a message
    Sender.send user, Enum.random(possible)

    # OK!
    { :ok, messages }
  end

  @doc """
  Fall Back for unknow messages
  """
  def handle_event(_, messages), do: { :ok, messages }
end
