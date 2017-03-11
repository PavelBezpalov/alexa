require 'test_helper'

class AlexaControllerTest < ActionDispatch::IntegrationTest
  test "should get listener" do
    get alexa_listener_url
    assert_response :success
  end

end
