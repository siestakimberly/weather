defmodule Weather.Print do
  alias Weather.Core

  @moduledoc """
  A function that makes 3 calls to our external API and prints out the average max temperature in Salt Lake City, Los Angeles, or Boise for a 6 day forecast.
  """

  @doc """
  Prints out the average max temperature in Salt Lake City, Los Angeles, and Boise for a 6 day forecast.

  ## Examples
  iex(2)> Weather.Print.print()

        Salt Lake City Average Max Temp: 37.82
        Los Angeles Average Max Temp: 71.92
        Boise Average Max Temp: 34.25

  :ok

  """
  @spec print() :: :ok
  def print() do
    results = Core.api_cities()

    IO.puts("
      Salt Lake City Average Max Temp: #{Enum.at(results, 0)}
      Los Angeles Average Max Temp: #{Enum.at(results, 1)}
      Boise Average Max Temp: #{Enum.at(results, 2)}
      ")
  end
end
