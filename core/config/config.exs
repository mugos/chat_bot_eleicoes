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
  token: "EAACzIvBu0y0BAIEYQRFAVzxkkJAOER6eoPvA8nwYylooILV9xJG6tuymVLxpKDvBtPfZBREd1r2wkZBqzOI2mKpV3hX8n6cRSNO8qKBPTGO9Y6H4GWIu2NHcNJZBaSJWwSWVNDJfQrZAwdLINyB2CXtbzbG2kNInzHKGfsaZBgAZDZD",
  verification: "T0pS3Cr3T"

# Luis Configurations
config :core, :luis,
  id: "35c27d37-9c52-453c-9ee9-c5f34db8cdf1",
  token: "35d9869c0b9444c88f57342cc2d03379"
