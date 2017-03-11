class AlexaController < ApplicationController
  before_action :understand_alexa
  before_action :authorize_user

  def listener
    response = AlexaRubykit::Response.new

    if @alexa_request.type == 'INTENT_REQUEST'
      logger.info "#{@alexa_request.slots}"
      logger.info "#{@alexa_request.name}"
      if @alexa_request.name == 'AddIncome'
        transaction_date = Date.parse(@alexa_request.slots['Date']['value'] || Date.today.to_s)
        transaction = Transaction.new(amount: @alexa_request.slots['Amount']['value'], transaction_date: transaction_date)
        if transaction.save
          response.add_speech("#{transaction.amount} hrivnas have been added for #{transaction.transaction_date}.")
        else
          response.add_speech("Error adding record. Please repeat.")
        end
      # elsif @alexa_request.name == ...
      end
    end

    if @alexa_request.type == 'LAUNCH_REQUEST'
      response.add_speech('FOP ready!')
    end

    if @alexa_request.type == 'SESSION_ENDED_REQUEST'
      logger.info "#{@alexa_request.type}"
      logger.info "#{@alexa_request.reason}"
      head 200 and return
    end

    render json: response.build_response, status: :ok
  end

  private

  def understand_alexa
    request_json = JSON.parse(request.raw_post)
    @alexa_request = AlexaRubykit.build_request(request_json)
    @alexa_session = @alexa_request.session
    raise StandardError.new('session without user') unless @alexa_session.user_defined?
  rescue => error
    render json: { errors: error.message }, status: :bad_request
  end

  def current_user
    @current_user
  end

  def authorize_user
    @current_user = User.find_or_create_by!(amazon_id: @alexa_session.user_id)
  end
end
