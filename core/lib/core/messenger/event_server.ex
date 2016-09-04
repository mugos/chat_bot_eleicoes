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
    GenEvent.start_link([{ :name, @server }])
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
  def challange(%{ "hub.mode" => "subscribe",
                   "hub.verify_token" => token,
                   "hub.challenge" => challenge } = _) do
    # Check if the token is the same
    case app_token == token do
      true -> { :ok, challenge }
      _ -> :error
    end
  end
  def challenge(_), do: :error

  @doc """
  """
  def receive(params) when is_bitstring(params) do
    response = Core.Messenger.Types.Response.parse(params)
    Logger.info("Recevied messsages #{inspect(response)}")

    {:ok, response}
  end

  def receive(%{"object" => "page"} = params) do
    response = Core.Messenger.Types.Response.parse(params)
    Logger.info("Recevied messsages #{inspect(response)}")

    {:ok, response}
  end

  def receive(params) do
    Logger.info("Webhook bad request with params #{inspect(params)}")
    :error
  end

  defp app_token, do: Application.get_env(:core, :fb)[:verification]
end
