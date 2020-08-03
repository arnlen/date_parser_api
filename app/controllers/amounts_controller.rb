require 'net/http'

class AmountsController < ApplicationController

  def parse
    source_amount = amount_params['amount']

    render json: {
      source: source_amount,
      amount: sanitize_amount(source_amount)
    }
  end

  private

  def sanitize_amount(source_amount)
    return '' unless source_amount

    # Convert "," to ".", remove spaces and € signs
    source_amount = source_amount.downcase.
      gsub(',', '.').
      gsub(' ', '').
      gsub('€', '').
      gsub('eur', '').strip

    # Remove potential duplicated "."
    source_amount.sub!('.', '') while source_amount.count('.') > 1

    # Convert USD to EUR
    if source_amount.include?('$') || source_amount.include?('usd')
      source_amount = source_amount.gsub('$', '').gsub('usd', '')
      source_amount = convert_usd_to_euro(source_amount)
    end

    source_amount
  end

  def convert_usd_to_euro(source_amount)
    uri = URI('https://api.exchangeratesapi.io/latest?base=USD')
    response = Net::HTTP.get_response(uri)
    body = JSON.parse(response.body)
    conversion_rate = body['rates']['EUR']

    converted_amount = conversion_rate * source_amount.to_f
    converted_amount.round(2).to_s
  end

  def amount_params
    params.permit(:amount)
  end

end
