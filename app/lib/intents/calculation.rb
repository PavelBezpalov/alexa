module Intents
  class Calculation
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
      start_period = current_quarter_months(Date.current)[0]
      end_period = current_quarter_months(Date.current)[2]
      to_pay = Transaction.where('transaction_date > ? AND transaction_date < ?', Date.parse("01-#{start_period.to_s}-#{Date.current.year.to_s}"),
                        Date.parse("01-#{end_period.to_s}-#{Date.current.year.to_s}").end_of_month).sum(:amount)*0.05
      response.add_speech("You have to pay #{to_pay} hrivnas from your current income.")
    end

    def current_quarter_months(date)
      quarters = [[1,2,3], [4,5,6], [7,8,9], [10,11,12]]
      quarters[(date.month - 1) / 3]
    end

  end
end
