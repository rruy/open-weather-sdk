require 'net/http'
require 'json'
require 'date'

class WeatherForecast
  attr_reader :api_key

  def initialize(api_key)
    @api_key = api_key
  end

  def forecast(latitude, longitude)
    url = "https://api.openweathermap.org/data/2.5/forecast?lat=#{latitude}&lon=#{longitude}&units=metric&appid=#{@api_key}"
    uri = URI(url)

    response = Net::HTTP.get(uri)
    json_response = JSON.parse(response)

    forecast_list = json_response['list']
    return [] if forecast_list.nil?

    forecast_calculate = []

    forecast_list.chunk { |day| formated_date(day['dt_txt']) }.each do |formatted_date, day_entries|
      count_days = day_entries.size
      media_temp_days = day_entries.sum { |day| day['main']['temp'] }

      forecast_calculate << {
        date: formatted_date,
        temperature: formated_celsius(media_temp_days / count_days)
      }

      puts forecast_calculate
    end

    forecast_calculate
  end

  private

  def formated_date(date)
    DateTime.parse(date).strftime('%d/%m/%Y')
  end

  def formated_celsius(temperature)
    sprintf("%.2f", temperature)
  end
end
