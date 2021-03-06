defmodule Weather.CoreTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/vcr_cassettes")
    :ok
  end

  describe "api_city_weather_slc/1" do
    test "it returns the max weather temperature for the requested city" do
      use_cassette "core_api_successful_request_1" do
        response = Weather.Core.api_cities() |> Enum.at(0)
        assert response == 37.76
      end
    end
  end

  describe "api_city_weather_la/1" do
    test "it returns the max weather temperature for the requested city" do
      use_cassette "core_api_successful_request_2" do
        response = Weather.Core.api_cities() |> Enum.at(1)
        assert response == 70.96
      end
    end
  end

  describe "api_city_weather_boise/1" do
    test "it returns the max weather temperature for the requested city" do
      use_cassette "core_api_successful_request_3" do
        response = Weather.Core.api_cities() |> Enum.at(2)
        assert response == 33.99
      end
    end
  end
end
