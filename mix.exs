defmodule GoogleGeocodingApi.Mixfile do
  use Mix.Project

  def project do
    [app: :google_geocoding_api,
     version: "0.1.2",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [{:httpoison, "~> 0.13.0"},
    {:poison, "~> 2.2 or ~> 3.0"},
    {:exvcr, "~> 0.7", only: :test},
    {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
   """
   An elixir wrapper for Google's geocoding API
   """
 end

  defp package do
   [files: ~w(lib mix.exs README.md LICENSE),
    maintainers: ["smythey21"],
    licenses: ["MIT"],
    links: %{"Github" => "https://github.com/smythey21/google-geocoding-api-elixir"}]
  end
end
