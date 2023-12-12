require_relative '../lib/weather_service'

class OpenWeatherSdk
  def self.call(api, city)
    WeatherService.new(api, city).call
  end
end
