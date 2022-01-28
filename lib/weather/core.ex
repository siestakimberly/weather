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
    sum_max_temp(sum_max_temp) / number_of_days() * 9 / 5 + 32
  end

  # ## Example
  # iex(1)> Weather.Boundary.api_city(0) |> Weather.Core.sum_max_temp()
  # 16.435

  @spec sum_max_temp(list) :: float

  defp sum_max_temp(api_city),
    do: @days |> Enum.map(&Boundary.day_max_temp(api_city, &1)) |> Enum.sum()

  @doc """
  Returns the average average max temperature of the given city for a 6 day forecast.

  ## Examples
  iex(7)> Weather.Core.api_city_weather(0)
  36.93
  """

  # This function should not take a city

  def get_weather_from_result(api_result) do
    api_result
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.fetch!("consolidated_weather")
    |> avg_max_temp()
    |> Float.round(2)
  end

  def api_cities do
    results = Boundary.call_apis_async() |> Enum.map(&get_weather_from_result/1)
  end
end
