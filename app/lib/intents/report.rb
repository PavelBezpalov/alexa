module Intents
  class Report
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
      if request.slots['Date']['value']
        period = define_period(request.slots['Date']['value'])
        amount = Transaction.where(transaction_date: period[:start_date]..period[:end_date]).sum(:amount)
        if amount > 0
          response.add_speech("Your income in #{request.slots['Date']['value']} is #{amount.to_i} hrivnas.")
        else
          response.add_speech("You don't have income in #{request.slots['Date']['value']}.")
        end
      else
        response.add_speech("Please specify report period.")
      end
    end

    def define_period(date)
      # hardcode default month to have it in the past :) update for production
      # 2016
      if /^(?<num>\d+)$/ =~ date
        start_date = Date.parse("01-01-#{date}")
        end_date = Date.parse("31-12-#{date}")
      elsif /^(?<num>\d+)$/ =~ date.gsub('-','') && date.split('-').size == 2
        # 2018-02 || 2017-02
        if date.split('-')[0].to_i > Date.current.year
          date.gsub!('2018', '2017')
        elsif date.split('-')[0].to_i == Date.current.year && date.split('-')[1].to_i > Date.current.month
          date.gsub!('2017', '2016')
        end
        start_date = Date.parse("01-#{date}")
        end_date = Date.parse("01-#{date}").end_of_month
      elsif date.include? 'Q'
        # 2018-Q1
        quarter = date.split('-Q')[1].to_i
        year = date.split('-Q')[0].gsub('2018','2017')
        month = if quarter == 1
                  1
                elsif quarter == 2
                  4
                elsif quarter == 3
                  7
                elsif quarter == 4
                  10
                else
                  1
                end
        start_date = Date.parse("01-#{month.to_s}-#{year}")
        end_date = Date.parse("01-#{(month+2)}-#{year}").end_of_month
      elsif date.include? 'W'
        # 2017-W10
        week = date.split('-W')[1].to_i
        year = date.split('-W')[0].to_i
        start_date = Date.commercial(year, week, 1)
        end_date = Date.commercial(year, week, 7)
      elsif /^(?<num>\d+)$/ =~ date.gsub('-','') && date.split('-').size == 3
        # 2017-03-11
        start_date = Date.parse(date)
        end_date = Date.parse(date)
      else
        # no data
        start_date = nil
        end_date = nil
      end

      return {start_date: start_date, end_date: end_date}
    end

  end
end
