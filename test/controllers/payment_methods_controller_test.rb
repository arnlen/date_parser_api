require 'test_helper'

class PaymentMethodsControllerTest < ActionDispatch::IntegrationTest

  source_payment_method = ''
  expected_response = {
    source: source_payment_method,
    payment_method: 'CB'
  }

  test "Without params" do
    get payment_methods_parse_url
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '', json_response['payment_method']
  end

  test "With empty payment_method" do
    source_payment_method = ''

    get payment_methods_parse_url, params: { payment_method: source_payment_method }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '', json_response['payment_method']
  end

  test "CB" do
    source_payment_method = 'CB'
    expected_response[:payment_method] = 'cb'

    get payment_methods_parse_url, params: { payment_method: source_payment_method }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:payment_method], json_response['payment_method']
  end

  test "Prélèvement" do
    source_payment_method = 'Prélèvement'
    expected_response[:payment_method] = 'prélèvement'

    get payment_methods_parse_url, params: { payment_method: source_payment_method }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:payment_method], json_response['payment_method']
  end

  test "Virement bancaire" do
    source_payment_method = 'Virement bancaire'
    expected_response[:payment_method] = 'virement'

    get payment_methods_parse_url, params: { payment_method: source_payment_method }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:payment_method], json_response['payment_method']
  end

end
