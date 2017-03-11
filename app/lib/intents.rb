module Intents
  class AddIncome
    attr_reader :user, :request

    def initialize(user, request)
      @user = user
      @request = request
    end

    def call
      process_request
    end

    def process_request
      transaction_date = Date.parse(@request.slots['Date']['value'] || Time.zone.today.to_s)
      transaction = Transaction.new(amount: @request.slots['Amount']['value'], transaction_date: transaction_date)
      if transaction.save
        response.add_speech("#{transaction.amount.to_i} hrivnas have been added for #{transaction.transaction_date}.")
      else
        response.add_speech("Error adding record. Please repeat.")
      end
    end
  end
end