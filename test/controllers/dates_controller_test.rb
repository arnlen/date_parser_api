require 'test_helper'

class DatesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get dates_create_url
    assert_response :success
  end

end
