module TodoableApi
  class Unauthorized < StandardError; end
  class NotFound < StandardError; end
  class UnprocessableEntity < StandardError; end
  class InternalServerError < StandardError; end
end