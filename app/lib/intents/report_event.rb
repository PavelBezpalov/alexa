module Intents
  class ReportEvent
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
      active_events = Event.where('start_date < ? AND end_date > ?', Date.current, Date.current)
      if active_events.any?
        if request.slots['Event_type']['value'] == 'deadline' || request.slots['Event_type']['value'] == 'report date'
          # TODO: extend it
          next_report = Event.order(:end_date).where('end_date > ?', Date.current).first
          # TODO: do not list done
          response.add_speech("Your next deadline is #{next_report.name} on #{next_report.end_date}")
        else
          response.add_speech("Your have next #{active_events.count} upcoming events: #{active_events.map { |event| event.name + ' on ' + event.end_date.to_s }.join(', ')}")
        end
      else
        response.add_speech("You don't have any upcoming reports or taxes.")
      end
    end
  end
end
