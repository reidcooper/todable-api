module TodoableApi
  class Item < BaseModel
    class << self
      def create(list_id, name)
        parse_response client.post(path: "lists/#{list_id}/items", params: { item: { name: name }})
      end

      def delete(list_id, this_id)
        parse_response client.delete(path: "lists/#{list_id}/items/#{this_id}")
      end

      def mark_as_finished(list_id, this_id)
        parse_response client.put(path: "lists/#{list_id}/items/#{this_id}/finish")
      end
    end
  end
end
