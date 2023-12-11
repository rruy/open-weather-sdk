require 'forecast'

class OpenWeatherSdk
  def self.call(city)
    Forecast.call(city)
  end
end
