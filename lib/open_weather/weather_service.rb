require_relative 'weather_forecast'
require_relative 'weather_message_builder'

module OpenWeather
  class WeatherService
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def call(city)
      weather = Weather.call(@api_key, city)
      forecast = WeatherForecast.new(@api_key).forecast(weather.latitude, weather.longitude)

      builder = WeatherMessageBuilder.new(weather.temperature[:celsius], weather.clouds, weather.city, Date.today, forecast)
      builder.build_message
    end
  end
end
