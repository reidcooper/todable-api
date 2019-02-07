require "net/http"
require "uri"
require "json"
require "date"

module TodoableApi
  module Sessionable
    attr_reader :auth_token

    # When called, make a request to Todoable's API to retrieve an authorization token
    # If already connected, return the stored token
    def connect!
      retrieve_auth_token unless connected?
      auth_token[:token]
    end

    # Returns the endpoint to authenticate the requests
    def auth_endpoint
      URI.join(TodoableApi.configuration.endpoint, 'api/authenticate')
    end

    # If already connected, return true. The token will expire after 20 minutes
    def connected?
      return false if auth_token.nil? || auth_token.empty?

      expires_at = auth_token.dig(:expires_at)

      return false if expires_at.nil?

      expires_at >= DateTime.now
    end

    private

    # Using basic auth, retrieve a auth token
    def retrieve_auth_token
      http = Net::HTTP.new(auth_endpoint.host, auth_endpoint.port)

      request = Net::HTTP::Post.new(auth_endpoint.request_uri)

      request.basic_auth(
        TodoableApi.configuration.username,
        TodoableApi.configuration.password
      )

      handle_auth_response(http.request(request))
    end

    # Handle the auth response, extracting the information we require and store
    # in the instance variable
    # Otherwise, store a blank token hash
    def handle_auth_response(response)
      @auth_token = {}

      # TODO: Fix this to handle error cases
      begin
        response = JSON.parse(response.body)
        @auth_token[:token] = response["token"]
        @auth_token[:expires_at] = DateTime.parse(response["expires_at"])
      rescue JSON::ParserError, TypeError
        @auth_token = {}
      end
    end
  end
end