require 'rails_helper'

RSpec.describe 'route for Alexa', type: :routing do
  it '"routes POST /alexa to the alexa controller" ' do
    expect(post('/alexa')).to route_to('alexa#listener')
  end
end
