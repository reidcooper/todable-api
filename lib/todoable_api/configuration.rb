module TodoableApi
  class Configuration
    attr_accessor :username
    attr_accessor :password
    attr_accessor :endpoint
    attr_accessor :client_class

    def initialize
      @endpoint = "http://todoable.teachable.tech"
      @client_class = TodoableApi::DefaultClient
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end