defmodule WeatherBoundaryTest do

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney


  setup do
    ExVCR.Config.cassette_library_dir("test/vcr_cassettes")
    :ok
  end


  describe "api_city()/1" do
    test "it returns the weather forecast for 6 days for a particular city" do
      use_cassette "weather_boundary_api_successful_request_1" do
        response = WeatherBoundary.api_city(0)
        assert Enum.count(response) == 6
      end
    end
  end


  describe "day_max_temp()/2" do
    test "it returns the max temperature for a given day" do
      use_cassette "weather_boundary_api_successful_request_2" do
        response = WeatherBoundary.api_city(1) |> WeatherBoundary.day_max_temp(3)
        assert response == 21.035
      end
    end
  end


end
