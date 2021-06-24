require 'net/http'

class QuoteService < ApplicationController

  def self.get_quotes_for_cryptos(tokens)
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

  def self.convert_usd_to_eur(usd_amount)
    base_url = Rails.env.development? ? 'sandbox-api' : 'pro-api'
    api_key = Rails.env.development? ? 'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c' : ENV['COIN_MARKET_CAP_API_KEY']
    url_params = "amount=#{usd_amount}&symbol=usd&convert=eur"
    uri = URI("https://#{base_url}.coinmarketcap.com/v1/tools/price-conversion?#{url_params}")

    request = Net::HTTP::Get.new(uri)
    request['X-CMC_PRO_API_KEY'] = api_key # CMC auth headers

    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    body = JSON.parse(response.body)
    body["data"]["quote"]["EUR"]["price"]
  end

end