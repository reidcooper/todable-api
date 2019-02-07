require 'todoable_api'

TodoableApi.configure do |config|
  config.username = "reid.cooper8@gmail.com"
  config.password = "todoable"
end

# Tests
list = TodoableApi::List.all.first
item = TodoableApi::Item.create(list.id, Time.now.to_s)
item.finish

true == true