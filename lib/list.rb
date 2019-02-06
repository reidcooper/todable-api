module TodoableApi
  class List < BaseModel
    class << self
      def all
        parse_response client.get(path: 'lists')
      end

      def create(name)
        parse_response client.post(path: 'lists', params: { list: { name: name }})
      end

      def find(this_id)
        parse_response client.get(path: "lists/#{this_id}")
      end

      def delete(this_id)
        parse_response client.delete(path: "lists/#{this_id}")
      end

      def update(this_id, name)
        parse_response client.patch(path: "lists/#{this_id}", params: { list: { name: name }})
      end
    end
  end
end