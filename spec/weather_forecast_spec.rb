require 'rspec'
require_relative '../lib/weather_forecast'

RSpec.describe WeatherForecast do
  let(:api_key) { 'your_api_key' }

  subject { described_class.new(api_key) }

  describe '#forecast' do
    let(:latitude) { 37.7749 }
    let(:longitude) { -122.4194 }

    context 'with valid data' do
      let(:json_response) do
        {
          'list' => [
            { 'dt_txt' => '2023-12-15 12:00:00', 'main' => { 'temp' => 25.0 } },
            { 'dt_txt' => '2023-12-15 15:00:00', 'main' => { 'temp' => 28.0 } },
            { 'dt_txt' => '2023-12-16 12:00:00', 'main' => { 'temp' => 22.0 } }
            # Add more entries as needed for testing
          ]
        }
      end

      before do
        allow(Net::HTTP).to receive(:get).and_return(json_response.to_json)
      end

      it 'returns formatted forecast data' do
        result = subject.forecast(latitude, longitude)

        expect(result).to be_an(Array)
        expect(result).not_to be_empty
        expect(result.first).to include(:date, :temperature)
      end
    end

    context 'with invalid data' do
      before do
        allow(Net::HTTP).to receive(:get).and_return('{}')  # Empty JSON response
      end

      it 'returns an empty array' do
        result = subject.forecast(latitude, longitude)

        expect(result).to eq([])
      end
    end
  end
end

