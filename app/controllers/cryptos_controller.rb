require 'net/http'

class CryptosController < ApplicationController

  def get_latest_quotes_for
    tokens = crypto_params['tokens']

    render json: QuoteService.get_quotes_for_cryptos(tokens)
  end

  private

  def crypto_params
    params.permit(:tokens)
  end

end
