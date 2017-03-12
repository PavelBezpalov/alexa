class AlexaController < ApplicationController
  before_action :understand_alexa
  before_action :authorize_user
  before_action :render_end_session, if: proc { @alexa_request.type == 'SESSION_ENDED_REQUEST' }
  before_action :register_user, if: proc { current_user.new? }
  before_action :render_launch_request, if: proc { @alexa_request.type == 'LAUNCH_REQUEST' }

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

  def render_launch_request
    response = AlexaRubykit::Response.new
    response.add_speech('FOP ready!')
    render json: response.build_response, status: :ok
  end

  def render_end_session
    logger.info @alexa_request.type.to_s
    logger.info @alexa_request.reason.to_s
    render json: {}, status: :ok
  end

  def register_user
    intent_handler = Intents::RegisterUser.new(current_user, @alexa_request)
    intent_handler.call
    render json: intent_handler.alexa_response, status: :ok
  end
end
