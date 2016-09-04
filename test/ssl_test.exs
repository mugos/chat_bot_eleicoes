defmodule WebhookTest do
  use ExUnit.Case
  doctest Core

  test "test handshake" do
    url = "https://api.projectoxford.ai/luis/v1/application?id=35c27d37-9c52-453c-9ee9-c5f34db8cdf1&subscription-key=2f618c2015ef48e1b899490fc7a2046b&q=hello"

    { :ok, 200, _headers, client } = :hackney.get(url, ['ocp-apim-subscription-key': '35d9869c0b9444c88f57342cc2d03379'])
    { :ok, body } = :hackney.body(client)
  end
end
