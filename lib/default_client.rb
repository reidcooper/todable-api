module TodoableApi
  class DefaultClient
    include Sessionable
    include HTTPRequestable

    def initialize
      @headers = default_headers
    end

    def get(path:, params: {})
      handle_preconditions do
        puts "GET"
        puts @headers
        puts request(method: :get, path: path, params: params, headers: @headers)
      end
    end

    def put(path:, params: {})
      handle_preconditions do
        puts "PUT"
        puts @headers
        puts request(method: :put, path: path, params: params, headers: @headers)
      end
    end

    def patch(path:, params: {})
      handle_preconditions do
        puts "PATCH"
        puts @headers
        puts request(method: :patch, path: path, params: params, headers: @headers)
      end
    end

    def delete(path:, params: {})
      handle_preconditions do
        puts "DELETE"
        puts @headers
        puts request(method: :delete, path: path, params: params, headers: @headers)
      end
    end

    private

    def handle_preconditions
      @headers["Authorization"] = "Token token=\"#{connect!}\""
      yield
    end

    def default_headers
      headers = {}
      headers["Accept"] = "application/json"
      headers["Content-Type"] = "application/json"
      headers
    end
  end
end