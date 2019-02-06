require_relative 'lib/todoable_api'

TodoableApi.configure do |config|
  config.username = "reid.cooper8@gmail.com"
  config.password = "todoable"
end

# Tests
puts TodoableApi.configuration.username
puts TodoableApi::Sessionable.new.connect!