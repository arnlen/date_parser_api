class DatesController < ApplicationController
  def parse
    parsed = Chronic.parse(params['date'], hours24: true)
    date_only = Date.parse("2020-04-28T12:00:00.000+02:00").to_s
    render json: {
      source: params['date'],
      date: date_only,
      datetime: parsed,
    }
  end
end
