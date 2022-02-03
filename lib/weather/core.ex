defmodule Weather.Core do
  alias Weather.Boundary

  @days [0, 1, 2, 3, 4, 5]

  @moduledoc """
    A collection of functions that calls on the Boundary layer to help find and calculate the average max temperature for the 6 day forecast for SLC, LA, and Boise;
  """

  @spec number_of_days() :: integer
  defp number_of_days() do
    @days |> length()
  end

  @spec day_max_temp(list, integer) :: float
  defp day_max_temp(api_city, day), do: Enum.at(api_city, day) |> Map.get("max_temp")

  @spec sum_max_temp(list) :: float
  defp sum_max_temp(api_city), do: @days |> Enum.map(&day_max_temp(api_city, &1)) |> Enum.sum()

  @spec avg_max_temp(list) :: float
  defp avg_max_temp(api_city) do
    sum_max_temp(api_city) / number_of_days() * 9 / 5 + 32
  end

  ## Example
  # iex(4)> Weather.Boundary.call_apis_async() |> Enum.at(0) |> Weather.Core.get_weather_from_result
  # 38.6

  @spec get_weather_from_result(struct) :: float
  defp get_weather_from_result(api_result) do
    api_result
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.fetch!("consolidated_weather")
    |> avg_max_temp()
    |> Float.round(2)
  end

  @doc """
  Returns a list of average max temperatures for each of the following cities in order: SLC, LA and Boise

  ## Example
  iex(4)> Weather.Core.api_cities
  [34.51, 70.93, 32.67]
  """

  @spec api_cities() :: list
  def api_cities() do
    Boundary.call_apis_async() |> Enum.map(&get_weather_from_result/1)
  end
end
