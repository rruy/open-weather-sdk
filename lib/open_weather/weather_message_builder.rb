require 'date'

module OpenWeatherSdk
  class WeatherMessageBuilder
    def initialize(temperature, conditions, city, date, forecast)
      @temperature = temperature
      @conditions = conditions.to_i
      @city = city
      @date = date
      @forecast = forecast
    end

    def build_message
      message = "#{@temperature}°C e #{conditions} em #{@city} em #{parse_date(@date)}."
      message += " Média para os próximos dias: #{build_forecast}."
      message
    end

    def conditions
      if @conditions.to_i < 50
        'Sol'
      else
        'Nublado'
      end
    end

    private

    def build_forecast
      @forecast.map { |day| "#{day[:temperature]}°C em #{parse_date(day[:date])}" }.join(', ')
    end

    def parse_date(date)
      Date.parse(date.to_s).strftime('%d/%m')
    end
  end
end
