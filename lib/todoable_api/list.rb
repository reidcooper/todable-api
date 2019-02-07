module TodoableApi
  class List < BaseModel
    class << self
      # Returns an array of all lists
      def all
        lists = client.get(path: 'lists')
        lists.fetch("lists", []).map do |list|
          TodoableApi::List.new(list)
        end
      end

      # Creates a new list and returns that list object
      def create(name)
        attributes = client.post(path: 'lists', params: { list: { name: name }})
        TodoableApi::List.new(attributes)
      end

      # Finds a list, returns a list object
      def find(this_id)
        attributes = client.get(path: "lists/#{this_id}")
        attributes["id"] = this_id
        TodoableApi::List.new(attributes)
      end

      # Delete a list
      def delete(this_id)
        client.delete(path: "lists/#{this_id}")
      end

      # Updates a list's name
      def update(this_id, name)
        client.patch(path: "lists/#{this_id}", params: { list: { name: name }})
      end
    end

    # Save an object's name, reload the object after a successful update
    def save
      self.class.update(id, name)
      reload
    end

    # Reload the current object in memory
    def reload
      @memoized_items = nil

      attributes = self.class.find(id).attributes

      initialize(attributes)

      self
    end

    # Set the name of the list
    def name=(new_name)
      @name = new_name
      attributes["name"] = new_name
    end

    # Create an array of TodoableApi::Item objects from the list
    def items
      reload if attributes["items"].nil?

      @memoized_items ||= attributes.fetch("items", []).map do |item|
        item["list_id"] = id
        TodoableApi::Item.new(item)
      end

      @memoized_items
    end
  end
end