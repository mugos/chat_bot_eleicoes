defmodule Core.AI do
  @moduledoc """
  This module is the magic of the Bot
  it is responsible for managingn the articifial inteligence
  """

  @doc """
  Execute the AI classification interaction
  """
  @spec classificate(String.t) :: HTTPotion.Response.t
  def classificate(message) do
    HTTPotion.get classification_url(message)
  end

  # def sentiment(message) do
  # end

  # Generate the JSON payload
  # defp payload(struct) do
  #   struct |> Poison.encode! |> elem(1)
  # end

  @spec classification_url(String.t) :: String.t 
  defp classification_url(message) do
    # Get the information from the Mix.Config
    config = Application.get_env(:core, :luis)

    # Return the URL
    "https://api.projectoxford.ai/luis/v1/application?id=" <> config[:id] <> "&subscription-key=" <> config[:key] <> "&q=" <> message
  end
end
