require "net/http"
require "uri"
require "json"

module TodoableApi
  class Sessionable
    SUCCESS_CODES = %w[200]
    ERROR_CODES = %w[400 401 403 404 408 422]

    attr_reader :auth_token

    def connect!
      retrieve_auth_token unless connected?
      puts auth_token
    end

    def uri
      URI.join(TodoableApi.configuration.endpoint, 'api/authenticate')
    end

    def connected?
      return false if auth_token.nil?

      expires_at = auth_token.dig(:expires)

      return false if expires_at.nil?

      expires_at >= Time.now
    end

    # private

    def retrieve_auth_token
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Post.new(uri.request_uri)

      request.basic_auth(
        TodoableApi.configuration.username,
        TodoableApi.configuration.password
      )

      handle_response(http.request(request))
    end

    def handle_response(response)
      @auth_token = nil

      if SUCCESS_CODES.include?(response.code)
        @auth_token = JSON.parse(response.body)
      elsif ERROR_CODES.include?(response.code)
        @auth_token = nil
      end
    end
  end
end