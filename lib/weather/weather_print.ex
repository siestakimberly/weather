defmodule WeatherPrint do
  alias Weather
@moduledoc """
A function that prints out the average max temperature in Salt Lake City, Los Angeles, or Boise for a 6 day forecast.
"""

@doc """
Prints out the average max temperature in Salt Lake City, Los Angeles, and Boise for a 6 day forecast.

## Examples
iex(2)> WeatherPrint.print()

      Salt Lake City Average Max Temp: 37.82
      Los Angeles Average Max Temp: 71.92
      Boise Average Max Temp: 34.25

:ok

"""

  def print() do
    IO.puts(
      "
      Salt Lake City Average Max Temp: #{WeatherCore.api_city_weather(0)}
      Los Angeles Average Max Temp: #{WeatherCore.api_city_weather(1)}
      Boise Average Max Temp: #{WeatherCore.api_city_weather(2)}
      "
      )
  end
end
