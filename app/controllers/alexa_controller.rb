class AlexaController < ApplicationController
  def listener
    request_json = JSON.parse(request.raw_post)
    alexa_request = AlexaRubykit.build_request(request_json)

    session = alexa_request.session
    p session.new?
    p session.has_attributes?
    p session.session_id
    p session.user_defined?
    response = AlexaRubykit::Response.new
    response.add_speech('Hello everlabs!')
    response.add_hash_card( { title: 'Everlabs Ready', subtitle: 'Working hard!' })
    render json: response.build_response
  end
end
