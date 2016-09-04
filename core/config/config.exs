# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :core, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:core, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
config :maru, Core.API,
  http: [port: 8000]

# Different Ports depending on the env
case Mix.env do
  :prod ->
    config :core, :port, 80
  _ ->
    config :core, :port, 8080
end

# Config messenger
config :core, :fb,
  token: "EAACzIvBu0y0BAIEYQRFAVzxkkJAOER6eoPvA8nwYylooILV9xJG6tuymVLxpKDvBtPfZBREd1r2wkZBqzOI2mKpV3hX8n6cRSNO8qKBPTGO9Y6H4GWIu2NHcNJZBaSJWwSWVNDJfQrZAwdLINyB2CXtbzbG2kNInzHKGfsaZBgAZDZD",
  verification: "T0pS3Cr3T"

# Luis Configurations
config :core, :luis,
  id: "35c27d37-9c52-453c-9ee9-c5f34db8cdf1",
  key: "ee51f545cf6c4f54bfd46145a151b4a6"
