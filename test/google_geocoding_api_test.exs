defmodule GoogleGeocodingApiTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  import ApiResponseTests

  setup do
    ExVCR.Config.cassette_library_dir("test/cassettes")

    on_exit fn ->
      Application.delete_env(:google_geocoding_api, :api_key)
    end

   :ok
  end

  describe "all_info" do
    test_all_response_types(:all_info,
      %{"results" => [%{"address_components" => [%{"long_name" => "30",
        "short_name" => "30", "types" => ["street_number"]},
      %{"long_name" => "Rockefeller Plaza", "short_name" => "Rockefeller Plaza",
        "types" => ["route"]},
      %{"long_name" => "Midtown", "short_name" => "Midtown",
        "types" => ["neighborhood", "political"]},
      %{"long_name" => "Manhattan", "short_name" => "Manhattan",
        "types" => ["political", "sublocality", "sublocality_level_1"]},
      %{"long_name" => "New York", "short_name" => "New York",
        "types" => ["locality", "political"]},
      %{"long_name" => "New York County", "short_name" => "New York County",
        "types" => ["administrative_area_level_2", "political"]},
      %{"long_name" => "New York", "short_name" => "NY",
        "types" => ["administrative_area_level_1", "political"]},
      %{"long_name" => "United States", "short_name" => "US",
        "types" => ["country", "political"]},
      %{"long_name" => "10112", "short_name" => "10112",
        "types" => ["postal_code"]}],
     "formatted_address" => "30 Rockefeller Plaza, New York, NY 10112, USA",
     "geometry" => %{"location" => %{"lat" => 40.7589632,
         "lng" => -73.97933739999999}, "location_type" => "ROOFTOP",
       "viewport" => %{"northeast" => %{"lat" => 40.76031218029149,
           "lng" => -73.9779884197085},
         "southwest" => %{"lat" => 40.75761421970849,
           "lng" => -73.9806863802915}}},
     "place_id" => "ChIJKeGo2v5YwokRGtFHIJK5DuQ",
     "types" => ["street_address"]}], "status" => "OK"}
    )
  end

  describe "geometry" do
    test_all_response_types(:geometry,
      %{"location" => %{"lat" => 40.7589632,
         "lng" => -73.97933739999999}, "location_type" => "ROOFTOP",
       "viewport" => %{"northeast" => %{"lat" => 40.76031218029149,
           "lng" => -73.9779884197085},
         "southwest" => %{"lat" => 40.75761421970849,
           "lng" => -73.9806863802915}}}
    )
  end

  describe "geo_location" do
    test_all_response_types(:geo_location, %{"lat" => 40.7589632, "lng" => -73.97933739999999})
  end

  describe "geo_location_northeast" do
    test_all_response_types(:geo_location_northeast, %{"lat" => 40.76031218029149, "lng" => -73.9779884197085})
  end

  describe "geo_location_southwest" do
    test_all_response_types(:geo_location_southwest, %{"lat" => 40.75761421970849, "lng" => -73.9806863802915})
  end

  describe "location_type" do
    test_all_response_types(:location_type, "ROOFTOP")
  end

  describe "formatted_address" do
    test_all_response_types(:formatted_address, "30 Rockefeller Plaza, New York, NY 10112, USA")
  end

  describe "place_id" do
    test_all_response_types(:place_id, "ChIJKeGo2v5YwokRGtFHIJK5DuQ")
  end

  describe "address_components" do
    test_all_response_types(:address_components,
      [%{"long_name" => "30",
        "short_name" => "30", "types" => ["street_number"]},
      %{"long_name" => "Rockefeller Plaza", "short_name" => "Rockefeller Plaza",
        "types" => ["route"]},
      %{"long_name" => "Midtown", "short_name" => "Midtown",
        "types" => ["neighborhood", "political"]},
      %{"long_name" => "Manhattan", "short_name" => "Manhattan",
        "types" => ["political", "sublocality", "sublocality_level_1"]},
      %{"long_name" => "New York", "short_name" => "New York",
        "types" => ["locality", "political"]},
      %{"long_name" => "New York County", "short_name" => "New York County",
        "types" => ["administrative_area_level_2", "political"]},
      %{"long_name" => "New York", "short_name" => "NY",
        "types" => ["administrative_area_level_1", "political"]},
      %{"long_name" => "United States", "short_name" => "US",
        "types" => ["country", "political"]},
      %{"long_name" => "10112", "short_name" => "10112",
        "types" => ["postal_code"]}]
    )
  end

  describe "types" do
    test_all_response_types(:types, ["street_address"])
  end
end
