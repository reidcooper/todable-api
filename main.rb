require_relative 'lib/todoable_api'

TodoableApi.configure do |config|
  config.username = "reid.cooper8@gmail.com"
  config.password = "todoable"
end

# Tests
puts TodoableApi::List.all
output = TodoableApi::List.find("39a90439-b8af-4ec5-8422-4056d36d6832")
byebug

true == true