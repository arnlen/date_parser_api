class DatesController < ApplicationController
  def parse
    parsed = Chronic.parse(params['date'], hours24: true)
    render json: parsed
  end
end
