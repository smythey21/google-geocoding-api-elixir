defmodule GoogleGeocodingApi do
  @moduledoc """
  Provides functions to interact with Google Geocoding API.
  """

  def all_info(address, opts \\ []) do
    result = Poison.decode!(make_request(address, opts).body)

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

  def geometry(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["geometry"]
  end

  def geo_location(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["geometry"]["location"]
  end

  def geo_location_northeast(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["geometry"]["viewport"]["northeast"]
  end

  def geo_location_southwest(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["geometry"]["viewport"]["southwest"]
  end

  def location_type(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["geometry"]["location_type"]
  end

  def formatted_address(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["formatted_address"]
  end

  def place_id(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["place_id"]
  end

  def address_components(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["address_components"]
  end

  def types(address, opts \\ []) do
    result = all_info(address, opts)
    if result, do: List.first(result["results"])["types"]
  end

  defp make_request(address, opts \\ []) do
    params =
      [address: address, region: Keyword.get(opts, :region, ""), key: key()]
      |> Enum.filter(&(elem(&1, 1) != nil))
      |> Enum.into(%{})

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
