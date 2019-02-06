module TodoableApi
  class DefaultClient
    include Sessionable

    def initialize
      @headers = default_headers
    end

    def get
      handle_preconditions do
        puts "GET"
        puts @headers
      end
    end

    def put
      handle_preconditions do
        puts "PUT"
        puts @headers
      end
    end

    def patch
      handle_preconditions do
        puts "PATCH"
        puts @headers
      end
    end

    def delete
      handle_preconditions do
        puts "DELETE"
        puts @headers
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