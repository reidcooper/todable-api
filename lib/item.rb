module TodoableApi
  class Item < BaseModel
    class << self
      def create(list_id, name)
        attributes = client.post(path: "lists/#{list_id}/items", params: { item: { name: name }})
        attributes["list_id"] = list_id
        TodoableApi::Item.new(attributes)
      end

      def delete(list_id, this_id)
        client.delete(path: "lists/#{list_id}/items/#{this_id}")
      end

      def mark_as_finished(list_id, this_id)
        client.put(path: "lists/#{list_id}/items/#{this_id}/finish")
      end
    end

    attr_accessor :finished_at, :list_id

    def finished?
      !finished_at.nil?
    end

    def finish
      return true if finished?

      begin
        self.class.mark_as_finished(list_id, id)
        attributes = list.reload.attributes["items"].find { |i| i["id"] == id }
        initialize(attributes)
        true
      rescue TodoableApi::NotFound
        false
      end
    end

    def list
      return nil unless list_id

      @list ||= TodoableApi::List.find(list_id)
    end
  end
end
