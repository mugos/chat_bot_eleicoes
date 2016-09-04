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

    # Generate URL
    url = "https://api.projectoxford.ai/luis/v1/application?id=#{config[:id]}&subscription-key=#{config[:key]}&q=#{URI.encode_www_form(message)}"

    # Request it
    { :ok, 200, _, client } = :hackney.get(url, ['ocp-apim-subscription-key': config[:token]])
    { :ok, body } = :hackney.body(client)

    # Parse the response
    body |> Poison.decode!
  end

  # def sentiment(message) do
  # end

  # Generate the JSON payload
  # defp payload(struct) do
  #   struct |> Poison.encode! |> elem(1)
  # end

  # defp classification_url(app, message) do
  #   # Return the URL
  #   "https://api.projectoxford.ai/luis/v1.0/prog/apps/#{app}/predict?example=#{message}"
  # end
end
