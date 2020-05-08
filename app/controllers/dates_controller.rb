class DatesController < ApplicationController

  def parse
    source_date = date_params['date']

    chronic_parsed = Chronic.parse(source_date, hours24: true)
    chronic_parsed_date = chronic_parsed.to_date.to_s if chronic_parsed

    begin
      date_international_parse = Date.parse_international(source_date)
    rescue NoMethodError, Date::Error => _
    end

    Rails.logger.info("ℹ️ Source params: #{date_params}")
    Rails.logger.info("ℹ️ Chronic parsed: #{chronic_parsed}")
    Rails.logger.info("ℹ️ International parsed: #{date_international_parse}")

    render json: {
      source: source_date,
      date: chronic_parsed_date || date_international_parse || ''
    }
  end

  def date_params
    params.permit(:date)
  end
end
