module TodoableApi
  class Item < BaseModel
    class << self
      # Creates a new Item
      # Associated the list_id since the server does not return the list id
      # Returns a new item
      def create(list_id, name)
        attributes = client.post(path: "lists/#{list_id}/items", params: { item: { name: name }})
        attributes["list_id"] = list_id
        TodoableApi::Item.new(attributes)
      end

      # Deletes an item
      # Returns blank response
      # If delete request failed, then an error will be raised
      def delete(list_id, this_id)
        client.delete(path: "lists/#{list_id}/items/#{this_id}")
      end

      # Marks an item as finished
      # Returns blank response
      # If delete request failed, then an error will be raised
      def mark_as_finished(list_id, this_id)
        client.put(path: "lists/#{list_id}/items/#{this_id}/finish")
      end
    end

    attr_accessor :finished_at, :list_id

    # If the attribute is nil, then item is NOT finished
    # Set then the item is finished
    def finished?
      !finished_at.nil?
    end

    # Shortcut to mark an item as finished
    def finish
      return true if finished?

      begin
        self.class.mark_as_finished(list_id, id)
        attributes = list.reload.attributes["items"].find { |i| i["id"] == id }
        initialize(attributes)
        true
      rescue TodoableApi::NotFound, TodoableApi::UnprocessableEntity
        false
      end
    end

    # If the item has a list_id, return the list associated to this item
    def list
      return nil unless list_id

      @list ||= TodoableApi::List.find(list_id)
    end
  end
end
