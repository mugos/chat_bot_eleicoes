defmodule Core.Mixfile do
  use Mix.Project

  def project do
    [app: :core,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :rethinkdb, :cowboy, :plug, :inets, :hackney],
      mod: {Core, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:rethinkdb, github: "hamiltop/rethinkdb-elixir"},
      {:cors_plug, "~> 1.1"},
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:hackney, github: "benoitc/hackney"}
    ]
  end
end
