defmodule WeatherBoundary do
  alias WeatherCalculations
@moduledoc """
A collection of functions that uses the MetaWeather API (https://www.metaweather.com/api/) to find the average max temperature in Salt Lake City, Los Angeles, or Boise for a 6 day forecast.
"""
  @urls ["https://www.metaweather.com/api/location/2487610/",
  "https://www.metaweather.com/api/location/2442047/",
  "https://www.metaweather.com/api/location/2366355/"]

  @urls %{"Salt Lake City" => "https://www.metaweather.com/api/location/2487610/",
  "Los Angeles" => "https://www.metaweather.com/api/location/2442047/",
  "Boise" => "https://www.metaweather.com/api/location/2366355/"}

@doc """
Returns a list that contains the %HTTPoison.Response{} for each url in @urls. Each %HTTPoison.Response{} contains the body, headers, request, request_url, and status code. The bones of which are shown in the example below.

## Examples

iex(1)> WeatherBoundary.call_apis_async()
[
  %HTTPoison.Response{
    body: "",
    headers: [
    ],
    request: %HTTPoison.Request{
    },
    request_url: "https://www.metaweather.com/api/location/2487610/",
    status_code: 200
  },
  %HTTPoison.Response{
  },
  %HTTPoison.Response{
  }
]
"""
@spec call_apis_async() :: list
  def call_apis_async() do
    @urls
    |> Task.async_stream(&HTTPoison.get!/1)
    |> Enum.into([], fn {:ok, res} -> res end)
  end
# I want to return back a list of tasks that get executed.

@doc """
Transforms our call_apis_async function to get the value of the decoded body of a specific url_city given by the integer.

## Examples
iex(6)> WeatherBoundary.api_city(0)
[
  %{
    "air_pressure" => 1032.0,
    "applicable_date" => "2022-01-20",
    "created" => "2022-01-20T17:29:17.264333Z",
    "humidity" => 68,
    "id" => 6180269842235392,
    "max_temp" => 4.5649999999999995,
    "min_temp" => -3.985,
    "predictability" => 75,
    "the_temp" => 3.295,
    "visibility" => 10.28773214427742,
    "weather_state_abbr" => "lr",
    "weather_state_name" => "Light Rain",
    "wind_direction" => 157.3131986341516,
    "wind_direction_compass" => "SSE",
    "wind_speed" => 3.693760091990774
  },
  %{
  },
  %{
  },
  %{
  },
  %{
  %{
  }
]

"""
@spec api_city(integer) :: list

def api_city(url_city) do
  response = call_apis_async() |> Enum.at(url_city)
  response_body_decoded = response.body |> Poison.decode!
  response_body_decoded["consolidated_weather"]
end



@doc """
Finds the max temperature in degrees celsius for any given city for any given day.

## Examples
iex(3)> WeatherBoundary.api_city(0) |> WeatherBoundary.day_max_temp(0)
4.5649999999999995

iex(3)> WeatherBoundary.api_city(1) |> WeatherBoundary.day_max_temp(3)
23.01
"""

@spec day_max_temp(list, integer) :: float

def day_max_temp(api_city, day) do
  day = Enum.at(api_city, day)
  day["max_temp"]
end


end




# The below code is mainly taken from the below website except for the `!` I added and the appropriate URL's for this code.
# https://www.toptechskills.com/elixir-phoenix-tutorials-courses/clean-concurrent-code-elixir-task-module/


# External API
# Boundary - It right now contains the call to the external API. It also is calling out to calculations and it should not. (Isolate the code that interacts with the third party service.)
# Calculations
# Printing
