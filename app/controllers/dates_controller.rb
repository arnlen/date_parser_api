class DatesController < ApplicationController
  def parse
    parsed = Chronic.parse(date_params['date'], hours24: true)
    Rails.logger.info("ℹ️ Params: #{date_params}")
    Rails.logger.info("ℹ️ Parsed: #{parsed}")

    date_only = parsed.to_date.to_s

    Rails.logger.info("ℹ️ Date only: #{date_only}")

    render json: {
      source: date_params['date'],
      date: date_only,
      datetime: parsed,
    }
  end

  def date_params
    params.permit(:date)
  end
end
