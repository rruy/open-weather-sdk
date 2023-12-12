# spec/weather_message_builder_spec.rb

require_relative '../lib/weather_message_builder'

RSpec.describe WeatherMessageBuilder do
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
end