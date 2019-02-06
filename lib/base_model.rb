module TodoableApi
  class BaseModel
    def self.client
      @client ||= TodoableApi.configuration.client_class.new
    end

    attr_reader :id
    attr_reader :raw_json
    attr_reader :errors

    def client
      BaseModel.client
    end

    def parse_response(json_body)
      @raw_json = json_body
      puts @raw_json
    end
  end
end