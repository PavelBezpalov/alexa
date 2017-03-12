module Intents
  class Done
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
      # TODO: disable event for the user
      if active_events.any?
        next_event = Event.order(:end_date).where('end_date > ?', Date.current).first
        completed = CompletedEvent.new(user: user, event: next_event)
        if completed.save
          response.add_speech("#{next_event.name} has been marked as completed.")
        else
          response.add_speech("Crap, error again!")
        end
      else
        response.add_speech("Your don't have upcoming deadlines")
      end
    end

  end
end
