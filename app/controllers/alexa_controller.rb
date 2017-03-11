class AlexaController < ApplicationController
  def listener
    request_json = JSON.parse(request.raw_post)
    alexa_request = AlexaRubykit.build_request(request_json)

    session = alexa_request.session
    p session.new?
    p session.has_attributes?
    p session.session_id
    p session.user_defined?
    Transaction.create(amount: alexa_request.slots['Amount']['value']) if alexa_request.slots.key?('Amount')
    response = AlexaRubykit::Response.new
    response.add_speech("Hello Everlabs! Your total income is #{Transaction.sum(:amount).to_i} hrivnas!")
    response.add_hash_card( { title: 'Everlabs Ready', subtitle: 'Working hard!' })
    render json: response.build_response
  end
end
