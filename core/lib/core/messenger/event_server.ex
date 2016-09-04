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
    GenEvent.add_mon_handler(@server, handler, [])
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

    # Messages
    messages = Core.Messenger.Types.Response.message_texts response

    # Users
    users = Core.Messenger.Types.Response.message_senders response

    # Here come the TAIL!!!!
    proccess_message messages, users

    # Log the message
    Logger.info("Recevied messsages #{inspect(response)}")

    # Return!
    { :ok, response }
  end

  # Process a message
  defp proccess_message([ message | tail ], [ user | user_tail ]) do
    # Classify the message
    class = Core.AI.classificate(message)["intents"] |> hd

    # Notify the message
    notify {:message, class, user, []}

    # Keep running it
    proccess_message(tail, user_tail)
  end
  defp proccess_message([], []), do: :ok

  # Verification token
  defp app_token, do: Application.get_env(:core, :fb)[:verification]
end
