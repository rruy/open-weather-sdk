require 'rspec'
require_relative '../../lib/open_weather/forecast_data_formatter'

RSpec.describe OpenWeather::ForecastDataFormatter do
  let(:weather_data) do
    double(
      'WeatherData',
      city: 'Test City',
      longitude: 123.45,
      latitude: 67.89,
      temperature: 75.0,
      pressure: 1013,
      humidity: 80,
      min_temperature: 70.0,
      max_temperature: 80.0,
      clouds: 20,
      wind_speed: 10.0,
      wind_angle: 180
    )
  end

  subject { described_class.new(weather_data) }

  describe '#formatted_data' do
    it 'returns the formatted data hash' do
      formatted_data = subject.formatted_data

      expect(formatted_data).to include(
        city: 'Test City',
        longitude: 123.45,
        latitude: 67.89,
        pressure: 1013,
        humidity: 80,
        min_temperature: 70.0,
        max_temperature: 80.0,
        clouds: 20,
        wind_speed: 10.0,
        wind_angle: 180
      )

      expect(formatted_data[:temperature]).to include(
        celsius: 23,
        fahrenheit: 75.0
      )
    end
  end

  describe '#to_celsius' do
    it 'converts Fahrenheit to Celsius' do
      celsius = subject.send(:to_celsius, weather_data)

      expect(celsius).to eq(23)
    end
  end
end