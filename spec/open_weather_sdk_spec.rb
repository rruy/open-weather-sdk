require_relative '../lib/open_weather_sdk'
require_relative '../lib/open_weather/weather_service'

require 'byebug'

RSpec.describe OpenWeatherSdk do
  let(:api_key) { 'your_api_key' }
  let(:city) { 'TestCity' }

  describe '.call' do
    it 'calls WeatherService with the correct arguments' do
     
      weather_service_double = double('OpenWeather::WeatherService')
      allow(OpenWeather::WeatherService).to receive(:new).with(api_key, city).and_return(weather_service_double)
      allow(weather_service_double).to receive(:call).and_return('test_result')

      result = described_class.call(api_key, city)

      expect(result).to eq('test_result')
    end
  end
end