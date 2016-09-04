#
defmodule Core.Messenger.EventServer do
  @moduledoc """
  """

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
end
