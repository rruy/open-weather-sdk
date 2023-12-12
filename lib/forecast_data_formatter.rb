module OpenWeatherSdk
  class ForecastDataFormatter
    attr_reader :weather_data

    def initialize(weather_data)
      @weather_data = weather_data
    end

    def formatted_data
      {
        city: weather_data.city,
        longitude: weather_data.longitude,
        latitude: weather_data.latitude,
        temperature: {
          celsius: to_celsius(weather_data),
          fahrenheit: weather_data.temperature
        },
        pressure: weather_data.pressure,
        humidity: weather_data.humidity,
        min_temperature: weather_data.min_temperature,
        max_temperature: weather_data.max_temperature,
        clouds: weather_data.clouds,
        wind_speed: weather_data.wind_speed,
        wind_angle: weather_data.wind_angle
      }
    end

    private

    def to_celsius(data)
      ((data.temperature.to_f - 32) * 5 / 9).to_i
    end
  end
end
