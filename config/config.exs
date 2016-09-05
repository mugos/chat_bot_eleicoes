# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Different Ports depending on the env
case Mix.env do
  :prod ->
    config :core, :port, 80
  _ ->
    config :core, :port, 8000
end

# Config messenger
config :core, :fb,
  token: "",
  verification: ""

# Luis Configurations
config :core, :luis,
  id: "",
  token: "",
  key: ""
