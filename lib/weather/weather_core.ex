defmodule WeatherCore do
  import WeatherBoundary
 @moduledoc """
  A collection of mathematical functions to find for a given city the max temperature of a given day, then the max temperature of a given 6 day period and ultimatley average max temperature for the given 6 day forecast.
"""


# ## Example
# iex(1)> WeatherBoundary.api_city(0) |> WeatherCore.avg_max_temp()
# 37.763

@spec avg_max_temp(list) :: float

defp avg_max_temp(sum_max_temp) do
 celsius = sum_max_temp(sum_max_temp)/ 6
 farenheight = celsius * 9/5 + 32
 farenheight
end


# ## Example
# iex(1)> WeatherBoundary.api_city(0) |> WeatherCore.sum_max_temp()
# 16.435

@spec sum_max_temp(list) :: float

defp sum_max_temp(api_city) do
  Enum.to_list(0..5) |> Enum.map(&day_max_temp(api_city, &1)) |> Enum.sum
end

@doc """
Returns the average average max temperature of the given city for a 6 day forecast.

## Examples
iex(7)> WeatherCore.api_city_weather(0)
36.93
"""
@spec api_city_weather(integer) :: float

def api_city_weather(city) do
  api_city(city) |> avg_max_temp() |> Float.round(2)
end

end
