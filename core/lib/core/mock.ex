defmodule Core.Mock do

  def analyze( %{"entry" => [ %{"messaging" => [ %{"message" => %{ "text" => text} } ] }]}) do
    :binary.match(text, "mock")
  end
end
