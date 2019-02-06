module TodoableApi
  class List < BaseModel
    def all
      client.get('lists')
    end

    def create(name)
      client.post('lists', list: { name: name })
    end

    def find(this_id)
      client.get("lists/#{this_id}")
    end

    def update(this_id, name)
      client.patch("lists/#{this_id}", list: { name: name })
    end

    def delete(this_id)
      client.delete("lists/#{this_id}")
    end
  end
end