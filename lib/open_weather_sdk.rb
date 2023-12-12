class OpenWeatherSdk
  def self.call(api, city)
    WeatherService.new(api, city).call
  end
end
