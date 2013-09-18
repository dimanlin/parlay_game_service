module ParlayGameService
  class ApiError < RuntimeError
    attr_reader :error_message, :error_token

    def initialize(hash)
      error = hash['results']['errors']['error']
      @error_message = error['message']
      @error_token = error['token']
    end

    def to_s
      "message: #{@error_message}; token: #{@error_token}"
    end

  end
end
