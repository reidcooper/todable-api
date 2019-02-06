module TodoableApi
  class Item < BaseModel
    def create(list_id, name)
      parse_response client.post("lists/#{list_id}/items", item: { name: name })
    end

    def mark_as_finished(list_id, this_id)
      parse_response client.put("lists/#{list_id}/items/#{this_id}/finish")
    end

    def delete(list_id, this_id)
      parse_response client.delete("lists/#{list_id}/items/#{this_id}")
    end
  end
end
