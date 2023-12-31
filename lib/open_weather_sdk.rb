require_relative 'open_weather/weather_service'

class OpenWeatherSdk
  def self.call(api, city)
    OpenWeather::WeatherService.new(api).call(city)
  end
end
