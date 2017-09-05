defmodule GoogleGeocodingApi do
  @moduledoc """
  Provides functions to interact with Google Geocoding API.
  """

  def all_info(address) do
    result = Poison.decode!(make_request(address).body)

    case result["status"] do
      "ZERO_RESULTS" ->
        nil
      "OVER_QUERY_LIMIT" ->
        raise GoogleGeocodingApiException, message: "You have reached your query limit"
      "REQUEST_DENIED" ->
        raise GoogleGeocodingApiException, message: "Your request was denied"
      "INVALID_REQUEST" ->
        raise GoogleGeocodingApiException, message: "Your request was invalid"
      "UNKNOWN_ERROR" ->
        raise GoogleGeocodingApiException, message: "Unknown error, this may succeed if you try again"
      _ ->
        result
    end
  end

  def geometry(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["geometry"]
  end

  def geo_location(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["geometry"]["location"]
  end

  def geo_location_northeast(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["geometry"]["viewport"]["northeast"]
  end

  def geo_location_southwest(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["geometry"]["viewport"]["southwest"]
  end

  def location_type(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["geometry"]["location_type"]
  end

  def formatted_address(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["formatted_address"]
  end

  def place_id(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["place_id"]
  end

  def address_components(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["address_components"]
  end

  def types(address) do
    result = all_info(address)
    if result, do: List.first(result["results"])["types"]
  end

  defp make_request(address) do
    params = %{address: address}
    if key, do: params = Map.put(params, :key, key)
    if region, do: params = Map.put(params, :region, region)

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

  defp region do
    Application.get_env(:google_geocoding_api, :region)
  end
end
