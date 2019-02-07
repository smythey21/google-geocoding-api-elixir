[![Build Status](https://travis-ci.org/smythey21/google-geocoding-api-elixir.svg?branch=master)](https://travis-ci.org/smythey21/google-geocoding-api-elixir)[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
# google-geocoding-api-elixir

An elixir wrapper for Google's geocoding API

## Installation

```elixir
def deps do
  [{:google_geocoding_api, "~> 0.1.4"}]
end
```

## Usage

```iex
# Return geo location for given address
iex(3)> GoogleGeocodingApi.geo_location("30 Rockefeller Plaza. New York, NY")
%{"lat" => 40.7589632, "lng" => -73.97933739999999}

# Return geo location with northeast viewport
iex(5)> GoogleGeocodingApi.geo_location_northeast("30 Rockefeller Plaza. New York, NY")
%{"lat" => 40.76031218029149, "lng" => -73.9779884197085}

# Return geo location with southwest viewport
iex(6)> GoogleGeocodingApi.geo_location_southwest("30 Rockefeller Plaza. New York, NY")
%{"lat" => 40.75761421970849, "lng" => -73.9806863802915}

# Return location type
iex(7)> GoogleGeocodingApi.location_type("30 Rockefeller Plaza. New York, NY")
"ROOFTOP"

$ Return all geometry info
iex(4)> GoogleGeocodingApi.geometry("30 Rockefeller Plaza. New York, NY")
%{"location" => %{"lat" => 40.7589632, "lng" => -73.97933739999999},
  "location_type" => "ROOFTOP",
  "viewport" => %{"northeast" => %{"lat" => 40.76031218029149,
      "lng" => -73.9779884197085},
    "southwest" => %{"lat" => 40.75761421970849, "lng" => -73.9806863802915}}}

# Return formatted address
iex(8)> GoogleGeocodingApi.formatted_address("30 Rockefeller Plaza. New York, NY")
"30 Rockefeller Plaza, New York, NY 10112, USA"

# Return place id
iex(9)> GoogleGeocodingApi.place_id("30 Rockefeller Plaza. New York, NY")
"ChIJKeGo2v5YwokRGtFHIJK5DuQ"

# Return address components
iex(10)> GoogleGeocodingApi.address_components("30 Rockefeller Plaza. New York, NY")
[%{"long_name" => "30", "short_name" => "30", "types" => ["street_number"]},
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
 %{"long_name" => "10112", "short_name" => "10112", "types" => ["postal_code"]}]

# Return types
iex(11)> GoogleGeocodingApi.types("30 Rockefeller Plaza. New York, NY")
["street_address"]

# Return all data from an address
iex(2)> GoogleGeocodingApi.all_info("30 Rockefeller Plaza. New York, NY")
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
```

## API Key

You can set your API key in `config.exs`

```elixir
config :google_geocoding_api,
  api_key: "YOUR_API_KEY"
```

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
