# google-geocoding-api-elixir

An elixir wrapper for Google's geocoding API

## NOTE

This repository is currently in unstable beta and not reccomended for production use

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `google_geocoding_api` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:google_geocoding_api, "~> 0.1.0"}]
    end
    ```

  2. Ensure `google_geocoding_api` is started before your application:

    ```elixir
    def application do
      [applications: [:google_geocoding_api]]
    end
    ```
