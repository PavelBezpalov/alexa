module Intents
  class AddIncome
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
      request.slots['Date']['value'].gsub!('2018', '2017') if request.slots['Date']['value'].present?
      transaction_date = Date.parse(request.slots['Date']['value'] || Time.zone.today.to_s)
      transaction = Transaction.new(amount: request.slots['Amount']['value'], transaction_date: transaction_date,
                                    user: user)

      if transaction.save
        response.add_speech("#{transaction.amount.to_i} hrivnas have been added for #{transaction.transaction_date}.")
      else
        response.add_speech('Error adding record. Please repeat.')
      end
    end
  end
end
