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



end
