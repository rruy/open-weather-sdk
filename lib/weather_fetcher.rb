module OpenWeatherSdk
  class WeatherFetcher
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def fetch_weather_data(city)
      Openweather2.configure do |config|
        config.endpoint = 'http://api.openweathermap.org/data/2.5/weather'
        config.apikey = @api_key
      end

      begin
        Openweather2.get_weather(city: city, units: 'imperial')
      rescue Openweather2::UnknownResponse => e
        nil
      end
    end
  end
end
