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
      source_amount = QuoteService.convert_usd_to_eur(source_amount)
    end

    source_amount
  end

  def amount_params
    params.permit(:amount)
  end

end
