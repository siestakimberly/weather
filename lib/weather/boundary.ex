defmodule Weather.Boundary do
  # mix format

  @moduledoc """
  A collection of functions that uses the MetaWeather API (https://www.metaweather.com/api/) to find the average max temperature in Salt Lake City, Los Angeles, or Boise for a 6 day forecast.
  """

  @urls [
    "https://www.metaweather.com/api/location/2487610/",
    "https://www.metaweather.com/api/location/2442047/",
    "https://www.metaweather.com/api/location/2366355/"
  ]

  @spec call_apis_async() :: list
  def call_apis_async() do
    @urls
    |> Task.async_stream(&HTTPoison.get!/1)
    |> Enum.into([], fn {:ok, res} -> res end)
  end

  @doc """
  Transforms our call_apis_async function to get the value of the decoded body of a specific url_city given by the integer.

  ## Examples
  iex(6)> Weather.Boundary.api_city(0)
  [
    %{
      "air_pressure" => 1022.5,
      "applicable_date" => "2022-02-01",
      "created" => "2022-02-01T23:29:16.375130Z",
      "humidity" => 49,
      "id" => 5298221669679104,
      "max_temp" => 0.36,
      "min_temp" => -5.734999999999999,
      "predictability" => 70,
      "the_temp" => 0.58,
      "visibility" => 13.764303964845304,
      "weather_state_abbr" => "lc",
      "weather_state_name" => "Light Cloud",
      "wind_direction" => 315.64014062879346,
      "wind_direction_compass" => "NW",
      "wind_speed" => 5.375694676833956
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
    call_apis_async()
    |> Enum.at(url_city)
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.fetch!("consolidated_weather")
  end

  @doc """
  Finds the max temperature in degrees celsius for any given city for days 0 through 5.

  ## Examples
  iex(1)> Weather.Boundary.api_city(0) |> Weather.Boundary.day_max_temp(0)
  0.36

  iex(1)> Weather.Boundary.api_city(1) |> Weather.Boundary.day_max_temp(3)
  21.22
  """

  @spec day_max_temp(list, integer) :: float
  def day_max_temp(api_city, day), do: Enum.at(api_city, day) |> Map.get("max_temp")
end
