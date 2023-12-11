
class OpenWeatherSdk
  def self.call(city)
    Forecast.new(city).call
  end
end
