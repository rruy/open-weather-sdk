# spec/weather_message_builder_spec.rb

require_relative '../../lib/open_weather/weather_message_builder'

RSpec.describe OpenWeather::WeatherMessageBuilder do
  let(:temperature) { 25 }
  let(:conditions) { 40 } # assuming 40 as an example conditions value
  let(:city) { 'TestCity' }
  let(:date) { Date.today }
  let(:forecast) { [{ temperature: 30, date: Date.today + 1 }, { temperature: 28, date: Date.today + 2 }] }

  subject { described_class.new(temperature, conditions, city, date, forecast) }

  describe '#build_message' do
    it 'builds a weather message with the correct format' do
      expected_message = "#{temperature}°C e Sol em #{city} em #{date.strftime('%d/%m')}. Média para os próximos dias: 30°C em #{(date + 1).strftime('%d/%m')}, 28°C em #{(date + 2).strftime('%d/%m')}."

      result = subject.build_message

      expect(result).to eq(expected_message)
    end
  end

  describe '#conditions' do
    it 'returns "Sol" for conditions < 50' do
      subject.instance_variable_set(:@conditions, 40)
      expect(subject.conditions).to eq('Sol')
    end

    it 'returns "Nublado" for conditions >= 50' do
      subject.instance_variable_set(:@conditions, 60)
      expect(subject.conditions).to eq('Nublado')
    end
  end

  describe '#build_forecast' do
    it 'builds a forecast string with the correct format' do
      expected_forecast = "30°C em #{(date + 1).strftime('%d/%m')}, 28°C em #{(date + 2).strftime('%d/%m')}"

      result = subject.send(:build_forecast)

      expect(result).to eq(expected_forecast)
    end
  end

  describe '#parse_date' do
    it 'parses the date to the correct format' do
      input_date = Date.new(2023, 12, 31)
      expected_parsed_date = '31/12'

      result = subject.send(:parse_date, input_date)

      expect(result).to eq(expected_parsed_date)
    end
  end

  describe '#build_message' do
    it 'builds a weather message' do
      forecast_data = [
        { temperature: 32, date: '13/12/2023' },
        { temperature: 25, date: '14/12/2023' },
        { temperature: 29, date: '15/12/2023' },
        { temperature: 33, date: '16/12/2023' },
        { temperature: 28, date: '16/12/2023' }
      ]

      builder = OpenWeather::WeatherMessageBuilder.new(34, 40, 'São Paulo', '12/12/2023', forecast_data)
      message = builder.build_message

      expected_message = '34°C e Sol em São Paulo em 12/12. Média para os próximos dias: 32°C em 13/12, 25°C em 14/12, 29°C em 15/12, 33°C em 16/12, 28°C em 16/12.'
      expect(message).to eq(expected_message)
    end
  end
end