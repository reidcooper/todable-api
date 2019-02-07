module TodoableApi
  class DefaultClient
    include Sessionable
    include HTTPRequestable

    def initialize
      @headers = default_headers
    end

    # Make a GET request, given a path (String) and params (Hash)
    # Returns a parsed JSON/String response from the HTTPRequestable module
    def get(path:, params: {})
      handle_preconditions do
        puts "GET"
        request(method: :get, path: path, params: params, headers: @headers)
      end
    end

    # Make a PUT request, given a path (String) and params (Hash)
    # Returns a parsed JSON/String response from the HTTPRequestable module
    def put(path:, params: {})
      handle_preconditions do
        puts "PUT"
        request(method: :put, path: path, params: params, headers: @headers)
      end
    end

    # Make a POST request, given a path (String) and params (Hash)
    # Returns a parsed JSON/String response from the HTTPRequestable module
    def post(path:, params: {})
      handle_preconditions do
        puts "POST"
        request(method: :post, path: path, params: params, headers: @headers)
      end
    end

    # Make a PATCH request, given a path (String) and params (Hash)
    # Returns a parsed JSON/String response from the HTTPRequestable module
    def patch(path:, params: {})
      handle_preconditions do
        puts "PATCH"
        request(method: :patch, path: path, params: params, headers: @headers)
      end
    end

    # Make a DELETE request, given a path (String) and params (Hash)
    # Returns a parsed JSON/String response from the HTTPRequestable module
    def delete(path:, params: {})
      handle_preconditions do
        puts "DELETE"
        request(method: :delete, path: path, params: params, headers: @headers)
      end
    end

    private

    # Handles preconditions before making a request
    # Here, we set the authorization header token after we successfully connect! to Todoable
    def handle_preconditions
      @headers["Authorization"] = "Token token=\"#{connect!}\""
      puts @headers
      yield
    end

    # Default headers
    def default_headers
      headers = {}
      headers["Accept"] = "application/json"
      headers["Content-Type"] = "application/json"
      headers
    end
  end
end