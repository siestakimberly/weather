defmodule Weather.Boundary do
  @moduledoc """
  A function that uses the MetaWeather API (https://www.metaweather.com/api/) to create a list containing the %HTTPoison.Response{} of SLC, LA, and Boise.
  """

  @urls [
    "https://www.metaweather.com/api/location/2487610/",
    "https://www.metaweather.com/api/location/2442047/",
    "https://www.metaweather.com/api/location/2366355/"
  ]

  @doc """

  ## Example
  [
  %HTTPoison.Response{
    body: "{\"consolidated_weather\":[{\"id\":5630741359624192,\"weather_state_name\":\"Light Rain\",\"weather_state_abbr\":\"lr\",\"wind_direction_compass\":\"NW\",\"created\":\"2022-02-03T02:29:17.246169Z\",\"applicable_date\":\"2022-02-02\",\"min_temp\":-7.625,\"max_temp\":-2.08,\"the_temp\":-1.53,\"wind_speed\":4.613071412601077,\"wind_direction\":318.0,\"air_pressure\":1027.5,\"humidity\":57,\"visibility\":13.754983396961743,\"predictability\":75},{\"id\":5717802661969920,\"weather_state_name\":\"Light Cloud\",\"weather_state_abbr\":\"lc\",\"wind_direction_compass\":\"N\",\"created\":\"2022-02-03T02:29:19.842646Z\",\"applicable_date\":\"2022-02-03\",\"min_temp\":-8.195,\"max_temp\":-1.4749999999999999,\"the_temp\":-0.04499999999999993,\"wind_speed\":3.94339625224953,\"wind_direction\":350.19175318955865,\"air_pressure\":1035.5,\"humidity\":60,\"visibility\":13.658670862164957,\"predictability\":70},{\"id\":5067791406202880,\"weather_state_name\":\"Light Cloud\",\"weather_state_abbr\":\"lc\",\"wind_direction_compass\":\"S\",\"created\":\"2022-02-03T02:29:22.676868Z\",\"applicable_date\":\"2022-02-04\",\"min_temp\":-6.67,\"max_temp\":1.635,\"the_temp\":2.57,\"wind_speed\":3.1355028223972004,\"wind_direction\":176.66604020406913,\"air_pressure\":1036.0,\"humidity\":59,\"visibility\":12.863937107293406,\"predictability\":70},{\"id\":5643109288378368,\"weather_state_name\":\"Light Cloud\",\"weather_state_abbr\":\"lc\",\"wind_direction_compass\":\"SE\",\"created\":\"2022-02-03T02:29:25.497770Z\",\"applicable_date\":\"2022-02-05\",\"min_temp\":-3.5,\"max_temp\":4.545,\"the_temp\":4.14,\"wind_speed\":3.8379064250775468,\"wind_direction\":143.08137612368222,\"air_pressure\":1034.0,\"humidity\":60,\"visibility\":11.767216952994513,\"predictability\":70},{\"id\":5298950841040896,\"weather_state_name\":\"Light Cloud\",\"weather_state_abbr\":\"lc\",\"wind_direction_compass\":\"NNW\",\"created\":\"2022-02-03T02:29:28.845702Z\",\"applicable_date\":\"2022-02-06\",\"min_temp\":-3.41,\"max_temp\":3.305,\"the_temp\":4.595,\"wind_speed\":3.332769618916197,\"wind_direction\":333.6082546690054,\"air_pressure\":1035.5,\"humidity\":62,\"visibility\":5.310238208860256,\"predictability\":70},{\"id\":5213042636750848,\"weather_state_name\":\"Clear\",\"weather_state_abbr\":\"c\",\"wind_direction_compass\":\"SE\",\"created\":\"2022-02-03T02:29:31.472477Z\",\"applicable_date\":\"2022-02-07\",\"min_temp\":-3.09,\"max_temp\":5.470000000000001,\"the_temp\":3.33,\"wind_speed\":2.063020361091227,\"wind_direction\":135.0,\"air_pressure\":1034.0,\"humidity\":52,\"visibility\":9.999726596675416,\"predictability\":68}],\"time\":\"2022-02-02T21:47:42.663161-07:00\",\"sun_rise\":\"2022-02-02T07:36:28.684038-07:00\",\"sun_set\":\"2022-02-02T17:45:19.883452-07:00\",\"timezone_name\":\"LMT\",\"parent\":{\"title\":\"Utah\",\"location_type\":\"Region / State / Province\",\"woeid\":2347603,\"latt_long\":\"39.499741,-111.547318\"},\"sources\":[{\"title\":\"BBC\",\"slug\":\"bbc\",\"url\":\"http://www.bbc.co.uk/weather/\",\"crawl_rate\":360},{\"title\":\"Forecast.io\",\"slug\":\"forecast-io\",\"url\":\"http://forecast.io/\",\"crawl_rate\":480},{\"title\":\"HAMweather\",\"slug\":\"hamweather\",\"url\":\"http://www.hamweather.com/\",\"crawl_rate\":360},{\"title\":\"Met Office\",\"slug\":\"met-office\",\"url\":\"http://www.metoffice.gov.uk/\",\"crawl_rate\":180},{\"title\":\"OpenWeatherMap\",\"slug\":\"openweathermap\",\"url\":\"http://openweathermap.org/\",\"crawl_rate\":360},{\"title\":\"Weather Underground\",\"slug\":\"wunderground\",\"url\":\"https://www.wunderground.com/?apiref=fc30dc3cd224e19b\",\"crawl_rate\":720},{\"title\":\"World Weather Online\",\"slug\":\"world-weather-online\",\"url\":\"http://www.worldweatheronline.com/\",\"crawl_rate\":360}],\"title\":\"Salt Lake City\",\"location_type\":\"City\",\"woeid\":2487610,\"latt_long\":\"40.759499,-111.888229\",\"timezone\":\"America/Denver\"}",
    headers: [
    ],
    request: %HTTPoison.Request{
      body: "",
      headers: [],
      method: :get,
      options: [],
      params: %{},
      url: "https://www.metaweather.com/api/location/2487610/"
    },
    request_url: "https://www.metaweather.com/api/location/2487610/",
    status_code: 200
  },
  %HTTPoison.Response{
  },
  %HTTPoison.Response{
  }
]
  """

  @spec call_apis_async() :: list
  def call_apis_async() do
    @urls
    |> Task.async_stream(&HTTPoison.get!/1)
    |> Enum.into([], fn {:ok, res} -> res end)
  end
end
