require 'rspec'
require_relative '../../lib/open_weather/weather'
require_relative '../../lib/open_weather/weather_fetcher'
require_relative '../../lib/open_weather/forecast_data_formatter'

RSpec.describe OpenWeather::Weather do
  let(:api_key) { 'your_api_key' }
  let(:city) { 'São Paulo' }

  subject { described_class.new(api_key, city) }

  describe '#call' do
    context 'with valid data' do
      let(:weather_data) do
        double(
          'WeatherData',
          city: 'São Paulo',
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

      before do
        allow(OpenWeather::WeatherFetcher).to receive(:new).and_return(double('OpenWeather::WeatherFetcher', fetch_weather_data: weather_data))
        allow(OpenWeather::ForecastDataFormatter).to receive(:new).and_return(double('OpenWeather::ForecastDataFormatter', formatted_data: {}))
      end

      it 'returns formatted weather data' do
        result = subject.call

        expect(result).to be_a(OpenStruct)
      end
    end

    context 'with invalid data' do
      before do
        allow(OpenWeather::WeatherFetcher).to receive(:new).and_return(double('OpenWeather::WeatherFetcher', fetch_weather_data: nil))
      end

      it 'returns nil' do
        result = subject.call

        expect(result).to be_nil
      end
    end
  end
end
