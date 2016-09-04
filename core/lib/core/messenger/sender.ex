#
defmodule Core.Messenger.Sender do
  @moduledoc """
  """

  # Logger!
  require Logger

  @doc """
  Send a message to an user
  """
  @spec send(String.t, String.t) :: HTTPotion.Response.t
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

  @doc """
  Generate the JSON payload for sending a message
  """
  defp payload(recepient, message) do
    %{ recipient: %{id: recepient}, message: %{text: message} }
      |> Poison.encode
      |> elem(1)
  end

  @doc """
  Send a Post using HTTPotion
  """
  defp post(body: body) do
    HTTPotion.post url, body: body, headers: ["Content-Type": "application/json"]
  end

  @doc """
  return the url to hit to send the message
  """
  defp url do
    query = "access_token=#{page_token}"
    "https://graph.facebook.com/v2.6/me/messages?#{query}"
  end


  @doc """
  """
  defp page_token do
    Application.get_env(:facebook_messenger, :facebook_page_token)
  end
end
