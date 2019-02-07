module TodoableApi
  class BaseModel
    class << self
      # Initializes a client from the configured client class
      def client
        @client ||= TodoableApi.configuration.client_class.new
      end
    end

    attr_accessor :id, :attributes, :name

    def initialize(attributes = {})
      assign_attributes(attributes)
    end

    # Given a hash, assign instance variables to each model based on hash input
    def assign_attributes(attributes = {})
      @attributes = attributes
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end