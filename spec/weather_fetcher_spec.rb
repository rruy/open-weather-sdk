require 'rspec'
require 'rspec/json_expectations' 
require 'openweather2'
require_relative '../lib/weather_fetcher'
require 'byebug'

RSpec.describe WeatherFetcher do
  let(:api_key) { '3b839e5f779bb4cc9605b08f05253905' } 

  subject { described_class.new(api_key) }

  describe '#fetch_weather_data' do
    let(:city) { 'Test City' } 

    context 'with valid data' do
      let(:response_data) do
        {
          'name' => 'Test City',
          'coord' => { 'lon' => 123.45, 'lat' => 67.89 },
          'main' => {
            'temp' => 75.0,
            'pressure' => 1013,
            'humidity' => 80,
            'temp_min' => 70.0,
            'temp_max' => 80.0
          },
          'clouds' => { 'all' => 20 },
          'wind' => { 'speed' => 10.0, 'deg' => 180 }
        }
      end

      before do
        allow(Openweather2).to receive(:get_weather).and_return(response_data)
      end

      it 'returns weather data' do
        result = subject.fetch_weather_data(city)

        expect(result).to be_a(Hash)
        expect(result).not_to be_empty

        expect(result['name']).to eq('Test City')
        expect(result['coord']['lat']).to eq(67.89)
        expect(result['coord']['lon']).to eq(123.45)
        expect(result['main']['temp']).to eq(75.0)
        expect(result['main']['pressure']).to eq(1013)
        expect(result['main']['humidity']).to eq(80)
        expect(result['main']['temp_min']).to eq(70.0)
        expect(result['main']['temp_max']).to eq(80.0)
        expect(result['clouds']).to eq('all' => 20)
        expect(result['wind']['speed']).to eq(10.0)
        expect(result['wind']['deg']).to eq(180)
      end
    end

    context 'with invalid data' do
      before do
        allow(Openweather2).to receive(:get_weather).and_raise(Openweather2::UnknownResponse)
      end

      it 'returns nil' do
        result = subject.fetch_weather_data(city)

        expect(result).to be_nil
      end
    end
  end
end
