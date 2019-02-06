module TodoableApi
  class BaseModel

    attr_reader :id
    attr_reader :raw_json
    attr_reader :errors

    def client
      @client ||= TodoableApi.configuration.client_class.new
    end

    def parse_response(json_body)
      @raw_json = json_body
    end
  end
end