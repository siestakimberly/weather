defmodule WeatherPrintTest do

  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney


  setup do
    ExVCR.Config.cassette_library_dir("test/vcr_cassettes")
    :ok
  end


  describe "print" do
    test "it successfully prints the max weather temperature for SLC, LA, and Boise" do
      use_cassette "weather_print_api_successful_request_6" do
        response = WeatherPrint.print()
        assert response == :ok
      end
    end
  end

end
