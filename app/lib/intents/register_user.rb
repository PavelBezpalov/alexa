module Intents
  class RegisterUser
    attr_reader :user, :request, :session
    attr_accessor :response
    attr_accessor :end_session

    def initialize(user, request)
      @user = user
      @request = request
      @session = request.session
      @response = AlexaRubykit::Response.new
      @end_session = false
    end

    def call
      process_request
    end

    def alexa_response
      response.build_response(end_session)
    end

    def process_request
      if should_init_dialog?
        init_register_dialog
      elsif should_ask_group?
        store_name_and_ask_group
      else should_update_user?
           update_user
      end
    end

    def should_init_dialog?
      request.type == 'LAUNCH_REQUEST' || (session.attributes[:name].nil? && request.:name != 'RegisterUser')
    end

    def init_register_dialog
      response.add_speech('Looks like you are not in our DB. Please, specify your name:')
      response.add_hash_card(title: 'Please, specify your name:',
                             subtitle: 'Tip: my name is ...')
    end

    def should_ask_group?
      session.attributes[:group].nil? && request.name == 'RegisterUser' && request.slots['Name']['value'].present?
    end

    def store_name_and_ask_group
      response.add_session_attribute(:name, request.slots['Name']['value'])
      response.add_speech('What is your tax group:')
      response.add_hash_card(title: 'Please, specify your tax group:',
                             subtitle: 'Tip: i am on second|third group')
    end

    def should_update_user?
      request.name == 'RegisterUser' && request.slots['Group']['value'].present?
    end

    def update_user
      user.update(username: session.attributes[:name], tax_group: tax_group)
      response.add_speech('Welcome to your new accountant interface. Lets try to add some income.')
      self.end_session = true
    end

    def tax_group
      if request.slots['Group']['value'] == 'second'
        2
      elsif %w(third 3rd).include? request.slots['Group']['value']
        3
      end
    end
  end
end
