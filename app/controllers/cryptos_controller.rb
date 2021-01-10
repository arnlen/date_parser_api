require 'net/http'

class CryptosController < ApplicationController

  def get_latest_quotes_for
    tokens = crypto_params['tokens']

    render json: get_quotes_from_coinmarketcap_for(tokens)
  end

  private

  def get_quotes_from_coinmarketcap_for(tokens)
    base_url = Rails.env.development? ? 'sandbox-api' : 'pro-api'
    api_key = Rails.env.development? ? 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c' : ENV['COIN_MARKET_CAP_API_KEY']
    url_params = "symbol=#{tokens}&convert=eur"
    uri = URI("https://#{base_url}.coinmarketcap.com/v1/cryptocurrency/quotes/latest?#{url_params}")

    request = Net::HTTP::Get.new(uri)
    request['X-CMC_PRO_API_KEY'] = api_key # CMC auth headers

    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    body = JSON.parse(response.body)

    quotes = []

    body['data'].each do |token_data|
      quotes.append({
        'symbol': "#{token_data[1]['symbol']}",
        'price': token_data[1]['quote']['EUR']['price']
      })
    end

    quotes
  end

  def crypto_params
    params.permit(:tokens)
  end

end
