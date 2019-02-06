module TodoableApi
  class BaseModel
    class << self
      def client
        @client ||= TodoableApi.configuration.client_class.new
      end

      def parse_response(json_body)
        @raw_json = json_body
        puts @raw_json
      end
    end
  end
end