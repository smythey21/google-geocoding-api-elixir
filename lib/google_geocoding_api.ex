defmodule GoogleGeocodingApi do
  @moduledoc """
  Provides functions to interact with Google Geocoding API.
  """

  def geo_location(address) do
    result = Poison.decode!(make_request(address).body)
    List.first(result["results"])["geometry"]["location"]
  end

  defp make_request(address) do
    params = %{address: address}
    if key, do: params = Map.put(params, :key, key)

    HTTPoison.start

    params
    |> URI.encode_query
    |> build_url
    |> HTTPoison.get!
  end

  defp build_url(params), do: "https://maps.googleapis.com/maps/api/geocode/json?" <> params

  defp key do
    Application.get_env(:google_geocoding_api, :api_key)
  end
end
