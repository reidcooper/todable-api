# TodoableApi

Wraps the API endpoints of Todoable's Todo Service. Once installed, you are able to manage your todo lists, items, as well as marking individual items as finished.

Work Log:

February 5th, 2019
Session 1 -
Start: 6:45pm
End: 9:18pm

February 6th, 2019
Session 2 -
Start: 8:18am
End: 8:52am

February 6th, 2019
Session 3 -
Start: 9:45am
End: 10:08am

February 6th, 2019
Session 4 -
Start: 5:22pm
End: 6:22pm

February 6th, 2019
Session 5 -
Start: 6:55pm
End: 9:59pm

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'todoable_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install todoable_api

## Usage

Once the gem is installed, you are able to use it in your code. Here is a code sample that illustrates usage

```ruby
require 'todoable_api'

# Initializes TodoableApi gem
TodoableApi.configure do |config|
  config.username = "username@example.com"
  config.password = "foobar"
  # Below are optional configurations that can be overriden
  # config.endpoint = "custom"
  # config.client_class = NewClientClass
end

# View all lists
TodoableApi::List.all

# Create a new list
list = TodoableApi::List.create("foobar")
list.name # foobar

# Find a list
found_list = TodoableApi::List.find(list.id)
fount_list.id == list.id # true

# Update a list
TodoableApi::List.update(list.id, "newname")

list.name = "updatedname"
list.save

list = TodoableApi::List.find(list.id)
list.name == "updatedname" # true

# Delete a list
TodoableApi::List.delete(list.id)

# Items
list.items
# [TodoableApi::Item, TodoableApi::Item, TodoableApi::Item, ...]

# Create a new item
item = TodoableApi::Item.create(list.id, "task1")
item.name == "task1" # true

# Delete an item
TodoableApi::Item.delete(list.id, item.id)

# Mark as finished
TodoableApi::Item.mark_as_finished(list.id, item.id)

item.finish
item.finished? # true

# Display list associated to item
item.list.id == list.id # true

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To run specs `bundle exec rspec`

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
