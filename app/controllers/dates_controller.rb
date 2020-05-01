class DatesController < ApplicationController
  def parse
    parsed = Chronic.parse(params['date'], hours24: true)
    date_only = Date.parse(parsed).to_s

    render json: {
      source: params['date'],
      date: date_only,
      datetime: parsed,
    }
  end
end
