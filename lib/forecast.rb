require 'byebug'

class Forecast
  attr_reader :city
  DEFAULT_CITY = 'São Paulo'.freeze

  def initialize(city)
    @city = city
  end

  def self.call(city)
    new(city).call
  end

  def call
    city ||= default_city
    weather_data = fetch_weather_data(city)

    OpenStruct.new(fill(weather_data))
  end

  private

  def default_city
    DEFAULT_CITY
  end

  def fetch_weather_data(city)
    Openweather2.get_weather(city: "#{city},BR", units: 'imperial')
  end

  def fill(data)
    {
      city: data.city,
      longitude: data.longitude,
      latitude: data.latitude,
      temperature: {
        celsius: to_celsius(data),
        fareinaitew: data.temperature
      },
      pressure: data.pressure,
      humidity: data.humidity,
      min_temperature: data.min_temperature,
      max_temperature: data.max_temperature,
      clouds: data.clouds,
      wind_speed: data.wind_speed,
      wind_angle: data.wind_angle
    }
  end

  def to_celsius(data)
    ((data.temperature.to_f - 32) * 5 / 9).to_i
  end
end
