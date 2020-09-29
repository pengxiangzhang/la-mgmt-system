require 'test_helper'

class AuthControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get auth" do
    get auth_controller_auth_url
    assert_response :success
  end

end
