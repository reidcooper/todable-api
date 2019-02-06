require_relative 'lib/todoable_api'

TodoableApi.configure do |config|
  config.username = "reid.cooper8@gmail.com"
  config.password = "todoable"
end

# Tests
# puts TodoableApi::DefaultClient.new.get(path: 'lists')
# puts TodoableApi::List.create('foobar-list')
# puts TodoableApi::List.delete("9c628ecc-3fa9-48c1-8e46-981d1775b5bf")
# puts TodoableApi::List.all

# puts TodoableApi::List.find("39a90439-b8af-4ec5-8422-4056d36d6832")
# puts TodoableApi::List.update("39a90439-b8af-4ec5-8422-4056d36d6832", "foobar-list")

# puts TodoableApi::List.all

# puts TodoableApi::Item.create("39a90439-b8af-4ec5-8422-4056d36d6832", "task-1")

puts TodoableApi::List.find("39a90439-b8af-4ec5-8422-4056d36d6832")

puts TodoableApi::Item.mark_as_finished("39a90439-b8af-4ec5-8422-4056d36d6832", "99d3f49e-157f-4a56-92d8-4d539abdec56")

puts TodoableApi::List.find("39a90439-b8af-4ec5-8422-4056d36d6832")

# puts TodoableApi::Item.delete("605135c4-8e94-4f30-9ee4-f9d9b2bd6797", "task-1")