require 'test_helper'

class DatesControllerTest < ActionDispatch::IntegrationTest

  source_date = ''
  expected_response = {
    source: source_date,
    date: '2020-08-05'
  }

  test "Root path without params" do
    get root_url
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '', json_response['date']
  end

  test "Root path with empty date" do
    source_date = ''

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal '', json_response['date']
  end

  test "Root path with 8/05/20" do
    source_date = '8/05/20'
    expected_response[:date] = '2020-08-05'

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:date], json_response['date']
  end

  test "Root path with 08/05/2020" do
    source_date = '08/05/2020'
    expected_response[:date] = '2020-08-05'

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:date], json_response['date']
  end

  test "Root path with 2020-05-08" do
    source_date = '2020-05-08'
    expected_response[:date] = '2020-05-08'

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:date], json_response['date']
  end

  test "Root path with 5 mai 2020" do
    source_date = '5 mai 2020'
    expected_response[:date] = '2020-05-05'

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:date], json_response['date']
  end

  test "Root path with 5 avril 2020" do
    source_date = '5 avril 2020'
    expected_response[:date] = '2020-04-05'

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:date], json_response['date']
  end

  test "Root path with 5 avr. 2020" do
    source_date = '5 avr. 2020'
    expected_response[:date] = '2020-04-05'

    get root_url, params: { date: source_date }
    json_response = JSON.parse(response.body)

    assert_response :success
    assert_equal expected_response[:date], json_response['date']
  end

end
