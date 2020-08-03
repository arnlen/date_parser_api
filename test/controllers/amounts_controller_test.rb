require 'test_helper'
require 'net/http'

class AmountsControllerTest < ActionDispatch::IntegrationTest

  source_amount = ''
  expected_response = {
    source: source_amount,
    amount: ''
  }

  test "Without params" do
    get amounts_parse_url
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '', json_response['amount']
  end

  test "With empty amount" do
    source_amount = ''

    get amounts_parse_url, params: { amount: source_amount }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '', json_response['amount']
  end

  AmountFixtures::NUMBER_FORMATS.each do |example|
    test example[:source] do
      source_amount = example[:source]
      expected_response[:amount] = example[:target]

      get amounts_parse_url, params: { amount: source_amount }
      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal expected_response[:amount], json_response['amount']
    end
  end

  AmountFixtures::EURO_SIGNS.each do |example|
    test example[:source] do
      source_amount = example[:source]
      expected_response[:amount] = example[:target]

      get amounts_parse_url, params: { amount: source_amount }
      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal expected_response[:amount], json_response['amount']
    end
  end

  AmountFixtures::USD_SIGNS.each do |example|
    test example[:source] do
      source_amount = example[:source]

      get amounts_parse_url, params: { amount: source_amount }
      json_response = JSON.parse(response.body)

      assert_response :success
      assert(source_amount.to_f < json_response['amount'].to_f)
    end
  end

end
