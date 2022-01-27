defmodule Weather.Core do
  alias Weather.Boundary

  @days [0, 1, 2, 3, 4, 5]
 @moduledoc """
  A collection of mathematical functions to used to calculate the average max temperature for a specified city's 6 day forecast.
"""

@spec avg_max_temp(list) :: integer

defp number_of_days() do
 @days |> length()
end

# ## Example
# iex(1)> Weather.Boundary.api_city(0) |> Weather.Core.avg_max_temp()
# 37.763

@spec avg_max_temp(list) :: float

defp avg_max_temp(sum_max_temp) do
 celsius = sum_max_temp(sum_max_temp)/ number_of_days()
 farenheight = celsius * 9/5 + 32
 farenheight
end




# ## Example
# iex(1)> Weather.Boundary.api_city(0) |> Weather.Core.sum_max_temp()
# 16.435

@spec sum_max_temp(list) :: float

defp sum_max_temp(api_city), do: @days |> Enum.map(&Boundary.day_max_temp(api_city, &1)) |> Enum.sum

@doc """
Returns the average average max temperature of the given city for a 6 day forecast.

## Examples
iex(7)> Weather.Core.api_city_weather(0)
36.93
"""
@spec api_city_weather(integer) :: float

def api_city_weather(city) do
  Boundary.api_city(city)
  |> avg_max_temp()
  |> Float.round(2)
end

end
