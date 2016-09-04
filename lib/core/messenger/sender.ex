#
defmodule Core.Messenger.Sender do
  @moduledoc """
  """

  # Logger!
  require Logger

  @doc """
  Send a message to an user
  """
  def send(recepient, message) do
    # Send a request
    res = post payload(recepient, message)

    # Log it
    Logger.info("response from FB #{inspect(res)}")

    # FB Response
    res
  end

  # Generate the JSON payload for sending a message
  defp payload(recepient, message) do
    %{ recipient: %{id: recepient}, message: %{text: message} }
      |> Poison.encode!
  end

  # Send a Post using HTTPotion
  defp post(body) do
    { :ok, status, headers, ref } = :hackney.request :post, url, ["Content-Type": "application/json"], body
    { :ok, body } = :hackney.body ref
    Poison.decode! body
  end

  # Return the url to hit to send the message
  defp url do
    query = "access_token=#{page_token}"
    "https://graph.facebook.com/v2.6/me/messages?#{query}"
  end

  defp page_token do
    Application.get_env(:core, :fb)[:token]
  end
end
