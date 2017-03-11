class AlexaController < ApplicationController
  include Intents

  before_action :understand_alexa
  before_action :authorize_user

  def listener
    response = AlexaRubykit::Response.new

    if @alexa_request.type == 'INTENT_REQUEST'
      logger.info @alexa_request.slots.to_s
      logger.info @alexa_request.name.to_s

      @alexa_request.name.constantenize.new(user: @current_user, request: @alexa_request)
    end

    response.add_speech('FOP ready!') if @alexa_request.type == 'LAUNCH_REQUEST'

    if @alexa_request.type == 'SESSION_ENDED_REQUEST'
      logger.info @alexa_request.type.to_s
      logger.info @alexa_request.reason.to_s
      head(200) && return
    end

    render json: response.build_response, status: :ok
  end

  private

  def understand_alexa
    request_json = JSON.parse(request.raw_post)
    @alexa_request = AlexaRubykit.build_request(request_json)
    @alexa_session = @alexa_request.session
    raise StandardError, 'session without user' unless @alexa_session.user_defined?
  rescue => error
    render json: { errors: error.message }, status: :bad_request
  end

  attr_reader :current_user

  def authorize_user
    @current_user = User.find_or_create_by!(amazon_id: @alexa_session.user_id)
  end
end
