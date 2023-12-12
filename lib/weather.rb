require 'openweather2'
require 'net/http'

module OpenWeatherSdk
  class Weather
    attr_reader :api_key, :city

    def initialize(api_key, city)
      @api_key = api_key
      @city = city
    end

    def self.call(api_key, city)
      new(api_key, city).call
    end

    def call
      city = @city.nil? ? default_city : @city
      weather_data = WeatherFetcher.new(@api_key).fetch_weather_data(city)

      unless weather_data.nil?
        OpenStruct.new(ForecastDataFormatter.new(weather_data).formatted_data)
      end
    end

    private

    def default_city
      'São Paulo'
    end
  end
end
