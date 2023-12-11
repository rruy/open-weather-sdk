# spec/forecast_spec.rb

require "spec_helper"
require "ostruct"
require "forecast"
require "openweather2"

RSpec.describe Forecast do
  describe ".call" do
    context "when city is provided" do
      it "returns forecast data for the specified city" do
        city = "São Paulo"
        weather_data = double(
          city: "Sao Paulo",
          longitude: 123.45,
          latitude: 67.89,
          temperature: 75.0,
          pressure: 1015,
          humidity: 60,
          min_temperature: 70.0,
          max_temperature: 80.0,
          clouds: 20,
          wind_speed: 10.0,
          wind_angle: 180
        )

        allow(Openweather2).to receive(:get_weather).with(city: "#{city},BR", units: 'imperial').and_return(weather_data)

        result = Forecast.call(city)

        expect(result.city).to eq("Sao Paulo")
        expect(result.longitude).to eq(123.45)
        expect(result.latitude).to eq(67.89)
        expect(result.temperature[:celsius]).to eq(23)
        expect(result.temperature[:fareinaitew]).to eq(75.0)
        expect(result.pressure).to eq(1015)
        expect(result.humidity).to eq(60)
        expect(result.min_temperature).to eq(70.0)
        expect(result.max_temperature).to eq(80.0)
        expect(result.clouds).to eq(20)
        expect(result.wind_speed).to eq(10.0)
        expect(result.wind_angle).to eq(180)
      end
    end

    context "when city is not provided" do
        it "returns forecast data for Sao Paulo by default" do
          default_city = "São Paulo"
          weather_data = double(
            city: "Sao Paulo",
            longitude: 123.45,
            latitude: 67.89,
            temperature: 75.0,
            pressure: 1015,
            humidity: 60,
            min_temperature: 70.0,
            max_temperature: 80.0,
            clouds: 20,
            wind_speed: 10.0,
            wind_angle: 180
          )

          allow(Openweather2).to receive(:get_weather).with(city: "#{default_city},BR", units: 'imperial').and_return(weather_data)

          result = Forecast.call(nil)

          expect(result.city).to eq("Sao Paulo")
          expect(result.longitude).to eq(123.45)
          expect(result.latitude).to eq(67.89)
          expect(result.temperature[:celsius]).to eq(23)
          expect(result.temperature[:fareinaitew]).to eq(75.0)
          expect(result.pressure).to eq(1015)
          expect(result.humidity).to eq(60)
          expect(result.min_temperature).to eq(70.0)
          expect(result.max_temperature).to eq(80.0)
          expect(result.clouds).to eq(20)
          expect(result.wind_speed).to eq(10.0)
          expect(result.wind_angle).to eq(180)
        end
      end
  end
end
