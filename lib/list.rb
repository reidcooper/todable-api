module TodoableApi
  class List < BaseModel
    def all
      parse_response client.get('lists')
    end

    def create(name)
      parse_response client.post('lists', list: { name: name })
    end

    def find(this_id)
      parse_response client.get("lists/#{this_id}")
    end

    def delete(this_id)
      parse_response client.delete("lists/#{this_id}")
    end

    def update(this_id, name)
      parse_response client.patch("lists/#{this_id}", list: { name: name })
    end
  end
end