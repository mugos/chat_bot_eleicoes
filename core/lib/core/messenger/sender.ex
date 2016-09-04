#
defmodule Core.Messenger.Sender do
  @moduledoc """
  """

  # Logger!
  require Logger

  @doc """
  Send a message to an user
  """
  @spec send(String.t, String.t) :: HTTPoison.Response.t
  def send(recepient, message) do
    # Send a request
    res = post(
      url: url,
      body: payload(recepient, message)
    )

    # Log it
    Logger.info("response from FB #{inspect(res)}")

    # FB Response
    res
  end

  # Generate the JSON payload for sending a message
  defp payload(recepient, message) do
    %{ recipient: %{id: recepient}, message: %{text: message} }
      |> Poison.encode!
      |> elem(1)
  end

  # Send a Post using HTTPotion
  defp post(body: body) do
    HTTPoison.post url, body, ["Content-Type": "application/json"]
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
