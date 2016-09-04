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
    # Get the information from the Mix.Config
    config = Application.get_env(:core, :luis)

    #
    HTTPotion.get classification_url, query: %{id: config[:id], 'subscription-key': config[:key]}, follow_redirects: true, timeout: 10000
  end

  # def sentiment(message) do
  # end

  # Generate the JSON payload
  # defp payload(struct) do
  #   struct |> Poison.encode! |> elem(1)
  # end

  defp classification_url do
    # Return the URL
    "https://api.projectoxford.ai/luis/v1/application" 
  end
end
