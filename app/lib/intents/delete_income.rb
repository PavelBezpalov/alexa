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
      transaction_date = Date.parse(request.slots['Date']['value'] || Time.zone.today.to_s)
      transaction_amount = request.slots['Amount']['value'].to_i
      requested_transactions = user.transactions.where(amount: transaction_amount, transaction_date: transaction_date)
      if requested_transactions.any?
        requested_transactions.last.destroy
        if requested_transactions.any?
          response.add_speech("One record from #{requested_transactions.count + 1} for
                              #{transaction_amount} hrivnas has been deleted for #{transaction_date}.")
        else
          response.add_speech("#{transaction_amount} hrivnas has been deleted for #{transaction_date}.")
        end
      else
        response.add_speech("I can't find records for #{transaction_amount.to_i} hrivnas for #{transaction_date}.")
      end
    end
  end
end
