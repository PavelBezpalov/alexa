class AlexaController < ApplicationController
  def listener
    request_json = JSON.parse(request.raw_post)
    alexa_request = AlexaRubykit.build_request(request_json)

    session = alexa_request.session
    logger.info session.new?
    logger.info session.has_attributes?
    logger.info session.session_id
    logger.info session.user_defined?

    response = AlexaRubykit::Response.new

    if (alexa_request.type == 'INTENT_REQUEST')
      logger.info "#{request.slots}"
      logger.info "#{request.name}"
      Transaction.create(amount: alexa_request.slots['Amount']['value']) if alexa_request.slots.key?('Amount')
      response.add_speech("Your total income is #{Transaction.sum(:amount).to_i} hrivnas!")
    end

    if (alexa_request.type == 'LAUNCH_REQUEST')
      response.add_speech('FOP reeeeeeaaaaaaaaaady!')
    end

    if (alexa_request.type =='SESSION_ENDED_REQUEST')
      logger.info "#{request.type}"
      logger.info "#{request.reason}"
      head 200 and return
    end

    render json: response.build_response
  end
end
