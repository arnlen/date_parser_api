require 'test_helper'
require 'net/http'

class CryptosControllerTest < ActionDispatch::IntegrationTest

  test "with valid params" do
    tokens = 'ETH'

    get cryptos_get_latest_quotes_for_url, params: { tokens: tokens }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal 'ETH', json_response[0]['symbol']
  end

end
