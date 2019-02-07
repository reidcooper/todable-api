require "net/http"
require "uri"

module TodoableApi
  module HTTPRequestable
    def request(method: :get, path:, params: {}, headers: {})
      uri = api_endpoint(path)
      http = Net::HTTP.new(uri.hostname, uri.port)

      case method
      when :get
        request = Net::HTTP::Get.new(uri, headers)
      when :put
        request = Net::HTTP::Put.new(uri, headers)
        request.body = params.to_json
      when :post
        request = Net::HTTP::Post.new(uri, headers)
        request.body = params.to_json
      when :patch
        request = Net::HTTP::Patch.new(uri, headers)
        request.body = params.to_json
      when :delete
        request = Net::HTTP::Delete.new(uri, headers)
      end

      handle_api_response(http.request(request))
    end

    def api_endpoint(path)
      URI.join(TodoableApi.configuration.endpoint, "api/#{path}")
    end

    def handle_api_response(response)
      case response.code.to_i
      when 204
        true
      when 200..300
        begin
          JSON.parse(response.body)
        rescue JSON::ParserError
          response.body
        end
      when 401
        raise TodoableApi::Unauthorized
      when 404
        raise TodoableApi::NotFound
      when 422
        raise TodoableApi::UnprocessableEntity, JSON.parse(response.body)
      when 500
        raise TodoableApi::InternalServerError
      end
    end
  end
end