require 'test_helper'

class DatesControllerTest < ActionDispatch::IntegrationTest

  test "should get parse" do
    get root_url
    assert_response :success
  end

end
