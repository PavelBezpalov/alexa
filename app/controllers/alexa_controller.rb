class AlexaController < ApplicationController
  before_action :understand_alexa
  before_action :authorize_user
  before_action :check_launch_request
  before_action :check_end_session

  def listener
    logger.info @alexa_request.slots.to_s
    logger.info @alexa_request.name.to_s
    intent_handler = "Intents::#{@alexa_request.name}".constantize.new(current_user, @alexa_request)
    intent_handler.call
    render json: intent_handler.alexa_response, status: :ok
  end

  private

  def understand_alexa
    @alexa_request = AlexaRubykit.build_request(params)
    @alexa_session = @alexa_request.session
    raise StandardError, 'session without user' unless @alexa_session.user_defined?
  rescue => error
    render json: { errors: error.message }, status: :bad_request
  end

  attr_reader :current_user

  def authorize_user
    @current_user = User.find_or_create_by!(amazon_id: @alexa_session.user_id)
  end

  def check_intent_type
    unless %w(LAUNCH_REQUEST SESSION_ENDED_REQUEST INTENT_REQUEST).include? @alexa_request.type
      render json: { errors: 'unknown intent type' }, status: :bad_request
    end
  end

  def check_launch_request
    if @alexa_request.type == 'LAUNCH_REQUEST'
      response = AlexaRubykit::Response.new
      response.add_speech('FOP ready!')
      render json: response.build_response, status: :ok
    end
  end

  def check_end_session
    if @alexa_request.type == 'SESSION_ENDED_REQUEST'
      logger.info @alexa_request.type.to_s
      logger.info @alexa_request.reason.to_s
      head :ok
    end
  end
end
