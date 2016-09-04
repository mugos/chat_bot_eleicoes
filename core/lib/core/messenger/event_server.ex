#
defmodule Core.Messenger.EventServer do
  @moduledoc """
  """

  # Logger!
  require Logger

  # Define the server name
  @server __MODULE__

  @doc """
  """
  def start_link([]) do
    { :ok, pid } = GenEvent.start_link([{ :name, @server }])
    add_handler(Core.Messenger.Handlers.GreetingHandler)
    { :ok, pid }
  end

  @doc """
  """
  def add_handler(handler) do
    GenEvent.add_handler(@server, handler, [])
  end

  @doc """
  """
  def notify(data) do
    GenEvent.notify(@server, data)
  end

  @doc """
  """
  def challenge(%{ "hub.verify_token" => token,
                   "hub.challenge" => challenge } = _) do
    # Check if the token is the same
    case token == app_token do
      true -> { :ok, challenge }
      _ -> :error
    end
  end
  def challenge(_), do: :error

  @doc """
  Receive the message from WebHook
  """
  def receive(params) when is_bitstring(params), do: _receive(params)
  def receive(%{"object" => "page"} = params), do: _receive(params)
  def receive(_), do: { :error, "Bad request" }

  # This will classify the question and parse everythin that it needs
  defp _receive(params) do
    # Parse the message
    response = Core.Messenger.Types.Response.parse(params)
    # TODO: patern match the shit out of this to get user
    # IO.inspect response

    # Notify
    notify {:message, 'GreetingMessage', "1212084815530974"}

    # Log the message
    Logger.info("Recevied messsages #{inspect(response)}")

    # Return!
    { :ok, response }
  end

  # Verification token
  defp app_token, do: Application.get_env(:core, :fb)[:verification]
end
