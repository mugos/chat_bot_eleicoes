defmodule Core.AI do
  @moduledoc """
  This module is the magic of the Bot
  it is responsible for managingn the articifial inteligence
  """

  @doc """
  Execute the AI classification interaction
  """
  def classificate(message) do
    # Get the information from the Mix.Config
    config = Application.get_env(:core, :luis)

    #
    # HTTPoison.get classification_url(config[:id], message), [{ "Ocp-Apim-Subscription-Key", config[:token] }]
    # HTTPoison.get "https://api.projectoxford.ai/luis/v1/application?id=35c27d37-9c52-453c-9ee9-c5f34db8cdf1", [{ "Ocp-Apim-Subscription-Key", config[:token] }] 

    url = "https://api.projectoxford.ai/luis/v1/application?id=#{config[:id]}&subscription-key=#{config[:key]}&q=#{message}"

    { :ok, 200, _headers, client } = :hackney.get(url, ['ocp-apim-subscription-key': config[:token]])
    { :ok, body } = :hackney.body(client)

    # IO.inspect body
    # IO.inspect Poison.parse!(body)
    body
  end

  # def sentiment(message) do
  # end

  # Generate the JSON payload
  # defp payload(struct) do
  #   struct |> Poison.encode! |> elem(1)
  # end

  defp classification_url(app, message) do
    # Return the URL
    "https://api.projectoxford.ai/luis/v1.0/prog/apps/#{app}/predict?example=#{message}"
  end
end
