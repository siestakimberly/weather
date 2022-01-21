defmodule WeatherTest do

    use ExUnit.Case
    # use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney


    # setup do
    #   ExVCR.Config.cassette_library_dir("test/vcr_cassettes")
    #   :ok
    # end


    describe "api_city_weather/1" do
      test "it returns the max weather temperature for the requested city" do
          response = WeatherCore.api_city_weather(2)
          assert response == 34.25
        end
    end


    # describe "api_city_weather/1" do
    #   test "it returns the max weather temperature for the requested city" do
    #     use_cassette "weather_api_successful_request" do
    #       response = Weather.api_city_weather(2)
    #       assert response == 34.25
    #     end
    #   end
    # end


end



#wrap the callout code into a cassette.
