# spec/forecast_service_spec.rb

require_relative '../lib/weather_service'
require_relative '../lib/weather'
require_relative '../lib/weather_forecast'
require_relative '../lib/weather_message_builder'

RSpec.describe WeatherService do
  let(:api_key) { 'test_api_key' }
  let(:city) { 'TestCity' }

  subject { described_class.new(api_key) }

  describe '#call' do
    it 'calls Weather, WeatherForecast, and WeatherMessageBuilder with the correct arguments' do
      allow(Weather).to receive(:call).with(api_key, city).and_return(double(latitude: 123, longitude: 456, temperature: { celsius: 20 }, clouds: 'cloudy', city: city))
      allow(WeatherForecast).to receive_message_chain(:new, :forecast).with(123, 456).and_return('test_forecast')

      weather_message_builder_double = double('WeatherMessageBuilder')
      allow(WeatherMessageBuilder).to receive(:new).and_return(weather_message_builder_double)
      allow(weather_message_builder_double).to receive(:build_message).and_return('test_message')

      result = subject.call(city)

      expect(result).to eq('test_message')
    end
  end
end
