module Intents
  class AddIncome
    def initialize(user, request)
      @user = user
      @request = request
    end

    transaction_date = Date.parse(@alexa_request.slots['Date']['value'] || Date.today.to_s)
    transaction = Transaction.new(amount: @alexa_request.slots['Amount']['value'], transaction_date: transaction_date)
    if transaction.save
      response.add_speech("#{transaction.amount.to_i} hrivnas have been added for #{transaction.transaction_date}.")
    else
      response.add_speech("Error adding record. Please repeat.")
    end
  end
end
