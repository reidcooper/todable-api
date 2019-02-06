require "net/http"
require "uri"
require "json"
require "date"

module TodoableApi
  module Sessionable
    SUCCESS_CODES = %w[200]
    ERROR_CODES = %w[400 401 403 404 408 422]

    attr_reader :auth_token

    def connect!
      retrieve_auth_token unless connected?
      auth_token[:token]
    end

    def uri
      URI.join(TodoableApi.configuration.endpoint, 'api/authenticate')
    end

    def connected?
      return false if auth_token.nil? || auth_token.empty?

      expires_at = auth_token.dig(:expires)

      return false if expires_at.nil?

      expires_at >= DateTime.now
    end

    private

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
      @auth_token = {}

      return unless SUCCESS_CODES.include?(response.code)

      begin
        response = JSON.parse(response.body)
        @auth_token[:token] = response["token"]
        @auth_token[:expires_at] = DateTime.parse(response["expires_at"])
      rescue JSON::ParserError
        @auth_token = {}
      end
    end
  end
end