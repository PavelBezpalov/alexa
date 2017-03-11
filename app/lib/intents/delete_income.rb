module Intents
  class DeleteIncome
    attr_reader :user, :request
    attr_accessor :response

    def initialize(user, request)
      @user = user
      @request = request
      @response = AlexaRubykit::Response.new
    end

    def call
      process_request
    end

    def alexa_response
      response.build_response
    end

    def process_request
    end
  end
end
