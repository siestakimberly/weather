defmodule WeatherBoundary do
@moduledoc """
A collection of functions that uses the MetaWeather API (https://www.metaweather.com/api/) to find the average max temperature in Salt Lake City, Los Angeles, or Boise for a 6 day forecast.
"""
  @urls ["https://www.metaweather.com/api/location/2487610/",
  "https://www.metaweather.com/api/location/2442047/",
  "https://www.metaweather.com/api/location/2366355/"]



@spec call_apis_async() :: list
  defp call_apis_async() do
    @urls
    |> Task.async_stream(&HTTPoison.get!/1)
    |> Enum.into([], fn {:ok, res} -> res end)
  end

@doc """
Transforms our call_apis_async function to get the value of the decoded body of a specific url_city given by the integer.

## Examples
iex(6)> WeatherBoundary.api_city(W0)
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
  },
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

#I'm thinking after I call my API's asychronously this is when I then need to get
#My question is my actual code is getting the requests back and assigning them to the correct city so why can't the test??

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
