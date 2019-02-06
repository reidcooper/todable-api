module TodoableApi
  class List < BaseModel
    class << self
      def all
        lists = client.get(path: 'lists')
        lists.fetch("lists", []).map do |list|
          TodoableApi::List.new(list)
        end
      end

      def create(name)
        attributes = client.post(path: 'lists', params: { list: { name: name }})
        TodoableApi::List.new(attributes)
      end

      def find(this_id)
        attributes = client.get(path: "lists/#{this_id}")
        attributes["id"] = this_id
        TodoableApi::List.new(attributes)
      end

      def delete(this_id)
        client.delete(path: "lists/#{this_id}")
      end

      def update(this_id, name)
        client.patch(path: "lists/#{this_id}", params: { list: { name: name }})
      end
    end

    def save
      self.class.update(id, name)
      reload
    end

    def reload
      attributes = self.class.find(id)
      initialize(attributes)
      self
    end

    def name=(new_name)
      @name = new_name
      attributes["name"] = new_name
    end

    def items
      @these_items ||= @items.map do |item|
        item["list_id"] = id
        TodoableApi::Item.new(item)
      end

      @these_items
    end
  end
end