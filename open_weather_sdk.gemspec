# frozen_string_literal: true

require_relative "lib/open_weather_sdk/version"

Gem::Specification.new do |spec|
  spec.name = "open_weather_sdk"
  spec.version = OpenWeatherSdk::VERSION
  spec.authors = ["Ricardo Ruy"]
  spec.email = ["ricardo.rruy@hotmail.com"]

  spec.summary = "Library to allow integrate with Api OpenWeather"
  spec.description = "Library to allow integrate with Api OpenWeather"
  spec.homepage = "http://www.github.com/rruy/open_weather_sdk"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["lib/**/*.rb"] + ["lib/open_weather_sdk.rb", "lib/forecast.rb"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "openweather2"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "rspec-mocks"
end
