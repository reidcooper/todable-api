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

  # Yields a new or existing configuration object
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Provides a block in order to customize the configuration
  def self.configure
    yield configuration
  end
end