defmodule WeatherCore do
  import WeatherBoundary
 @moduledoc """
  A collection of mathematical functions to find for a given city the max temperature of a given day, then the max temperature of a given 6 day period and ultimatley average max temperature for the given 6 day forecast.
"""
@doc """
Calculates the average max temperature in degrees farenheight for any given city for a 6 day forecast.

## Examples

iex(1)> WeatherBoundary.api_city(1) |> WeatherCore.sum_max_temp()
133.05499999999998
iex(2)> WeatherBoundary.api_city(0) |> WeatherCore.sum_max_temp()
19.39

"""

@spec avg_max_temp(list) :: float


def avg_max_temp(api_city) do
 celsius = sum_max_temp(api_city)/ 6
 farenheight = celsius * 9/5 + 32
 farenheight
end



@doc """
Calculates the sum max temperature in degrees celsius for any given city for a 6 day forecast.

## Examples
iex(1)> WeatherBoundary.api_city(0) |> WeatherCore.sum_max_temp()
16.435

iex(2)> WeatherBoundary.api_city(1) |> WeatherCore.sum_max_temp()
131.43
"""

@spec sum_max_temp(list) :: float

def sum_max_temp(api_city) do
  Enum.sum([WeatherBoundary.day_max_temp(api_city, 0), WeatherBoundary.day_max_temp(api_city, 1), WeatherBoundary.day_max_temp(api_city, 2), WeatherBoundary.day_max_temp(api_city, 3), WeatherBoundary.day_max_temp(api_city, 4), WeatherBoundary.day_max_temp(api_city, 5)])
end

#The above code I need to refactor to use Enum.to_list and Enum.reduce to look something more like the below commented out sum_max_temp(city) function

# def sum_max_temp(city) do
#   Enum.to_list(0..5)
#   |> Enum.reduce(&day_max_temp(city, &1))
# end


@doc """
Returns the average average max temperature of the given city for a 6 day forecast.

## Examples
iex(7)> WeatherCore.api_city_weather(0)
36.93
"""
@spec api_city_weather(integer) :: float

def api_city_weather(city) do
  WeatherBoundary.api_city(city) |> WeatherCore.avg_max_temp() |> Float.round(2)
end

end
